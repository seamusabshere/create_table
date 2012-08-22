require 'create_table/version'
require 'create_table/parser'
require 'create_table/column_name_based_collection'

require 'create_table/column'
require 'create_table/index'
require 'create_table/unique'

# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin
%%{
  machine parser;

  include "create_table/common.rl";

  action StartTableName   { start_table_name = p                                  }
  action EndTableName     { self.table_name = read(data, start_table_name, p)     }

  action StartColumn      { start_column = p                                      }
  action EndColumn        { parse_column read(data, start_column, p)              }
  
  action StartPrimaryKey  { start_primary_key = p                                 }
  action EndPrimaryKey    { self.primary_key = read(data, start_primary_key, p)   }
  
  action StartUnique      { start_unique = p                                      }
  action EndUnique        { parse_unique read(data, start_unique, p)              }
  
  action StartIndex       { start_index = p                                       }
  action EndIndex         { parse_index read(data, start_index, p)                }

  # conditions
  action NotEnclosedInParentheses { parens == 0 }

  create_table           = 'create'i space+ ('temporary'i space+ @{@temporary=true})? 'table'i;
  
  table_name             = quote_ident ident >StartTableName %EndTableName quote_ident;
  
  column_name            = quote_ident (ident - ('index'i | 'primary'i | 'unique'i | 'key'i | 'constraint'i)) >StartColumn quote_ident;
  column_options         = with_parens %EndColumn :> [,)] when NotEnclosedInParentheses;
  column_definition      = space* column_name space+ column_options;

  primary_key_definition = space* ('constraint'i space+)? 'primary'i space+ 'key'i lparens quote_ident ident >StartPrimaryKey %EndPrimaryKey quote_ident rparens :> [,)];
  unique_definition      = space* ('constraint'i space+)? 'unique'i (space+ ('key'i | 'index'i))? with_parens >StartUnique %EndUnique :> [,)] when NotEnclosedInParentheses;
  index_definition       = space* ('index'i | 'key'i) with_parens >StartIndex %EndIndex :> [,)] when NotEnclosedInParentheses;

  main := space* create_table space+ table_name space+ lparens (column_definition | primary_key_definition | unique_definition | index_definition)+ rparens;
}%%
=end

class CreateTable
  class << self
    def quote_ident(ident, options = {})
      @reserved_words ||= (IO.readlines(File.expand_path('../create_table/mysql_reserved.txt', __FILE__)) + IO.readlines(File.expand_path('../create_table/pg_reserved.txt', __FILE__))).map(&:chomp).sort.uniq
      quote_ident = options.fetch(:quote_ident, QUOTE_IDENT)
      if @reserved_words.include?(ident.upcase)
        quote_ident + ident + quote_ident
      else
        ident
      end
    end
  end

  include Parser

  QUOTE_IDENT = '"'
  BACKTICK = '`'

  attr_reader :columns
  attr_reader :indexes

  attr_accessor :table_name
  attr_accessor :temporary
  
  def initialize(sql = nil)
    @columns = ColumnNameBasedCollection.create
    @indexes = ColumnNameBasedCollection.create
    if sql
      parse sql
    end
  end

  def column_count
    columns.length
  end

  def primary_key=(column_name)
    if column_name.nil?
      @primary_key = nil
    else
      @primary_key = column_name.to_s
      i = Index.new self
      i.column_names = @primary_key
    end
    nil
  end

  def primary_key
    columns[@primary_key]
  end

  def parse_column(str)
    c = Column.new self
    c.parse str
    c
  end

  def add_unique(column_names)
    u = Unique.new self
    u.column_names = column_names
    u
  end

  def parse_unique(str)
    u = Unique.new self
    u.parse str
    u
  end

  def add_index(column_names, index_name = nil)
    i = Index.new self
    i.column_names = column_names
    i.name = index_name if index_name
    i
  end

  def parse_index(str)
    i = Index.new self
    i.parse str
    i
  end

  def create_table_sql(format, options)
    x = []
    x << 'CREATE'
    x << 'TEMPORARY' if temporary
    x << %{TABLE #{quoted_table_name(options)} (}
    x << columns.map { |c| c.to_sql(format, options) }.join(', ')
    x << ')'
    x.join ' '
  end

  def create_indexes_sql(format, options)
    indexes.map { |i| i.to_sql(format, options) }.compact
  end

  def to_sql(format, options)
    [create_table_sql(format, options)] + create_indexes_sql(format, options)
  end

  def to_postgresql(options = {})
    to_sql :postgresql, options
  end

  def to_mysql(options = {})
    defaults = { :quote_ident => BACKTICK }
    to_sql :mysql, defaults.merge(options)
  end

  def to_sqlite3(options = {})
    to_sql :sqlite3, options
  end

  def quoted_table_name(options)
    CreateTable.quote_ident table_name, options
  end

  def parse(str)
    data = Parser.remove_comments(str).unpack('c*')
    %% write data;
    # % (this fixes syntax highlighting)
    parens = 0
    p = item = 0
    pe = eof = data.length
    %% write init;
    # % (this fixes syntax highlighting)
    %% write exec;
    # % (this fixes syntax highlighting)
    self
  end
end
