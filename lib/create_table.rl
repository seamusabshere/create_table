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

  action StartTableName {
    start_table_name = p
  }
  action EndTableName {
    self.table_name = read(data, start_table_name, p)
    start_table_name = nil
  }
  action StartColumn {
    $stderr.puts "StartColumn(#{p})" if ENV['VERBOSE'] == 'true'
    start_column = p
  }
  action EndColumn {
    $stderr.puts "EndColumn(#{start_column}, #{p}) - #{read(data, start_column, p).inspect}" if ENV['VERBOSE'] == 'true'
    parse_column read(data, start_column, p)
    start_column = nil
  }
  action StartPrimaryKey {
    $stderr.puts "StartPrimaryKey(#{p})" if ENV['VERBOSE'] == 'true'
    start_primary_key = p
  }
  action EndPrimaryKey {
    $stderr.puts "EndPrimaryKey(#{start_primary_key}, #{p}) - #{read(data, start_primary_key, p).inspect}" if ENV['VERBOSE'] == 'true'
    self.primary_key = read(data, start_primary_key, p)
    start_primary_key = nil
  }
  action StartUnique {
    $stderr.puts "StartUnique(#{p})" if ENV['VERBOSE'] == 'true'
    start_unique = p
  }
  action EndUnique {
    $stderr.puts "EndUnique(#{start_unique}, #{p}) - #{read(data, start_unique, p).inspect}" if ENV['VERBOSE'] == 'true'
    parse_unique read(data, start_unique, p)
    start_unique = nil
  }
  action StartIndex {
    $stderr.puts "StartIndex(#{p})" if ENV['VERBOSE'] == 'true'
    start_index = p
  }
  action EndIndex {
    $stderr.puts "EndIndex(#{start_index}, #{p}) - #{read(data, start_index, p).inspect}" if ENV['VERBOSE'] == 'true'
    parse_index read(data, start_index, p)
    start_index = nil
  }

  # conditions
  action NotEnclosedInParentheses {
    r = (parens == 0)
    $stderr.puts "outside => #{r.inspect} (parens = #{parens.inspect})" if ENV['VERBOSE'] == 'true'
    r
  }

  create_table           = 'create'i space+ ('temporary'i space+ @{@temporary=true})? 'table'i;
  
  table_name             = quote ident >StartTableName %EndTableName quote;
  
  column_name            = quote (ident - ('index'i | 'primary'i | 'unique'i | 'key'i)) >StartColumn quote;
  column_options         = options %EndColumn :> [,)] when NotEnclosedInParentheses;
  column_definition      = space* column_name space+ column_options;
  
  primary_key_definition = space* 'primary'i space+ 'key'i lparens quote ident >StartPrimaryKey %EndPrimaryKey quote rparens :> [,)];

  unique_definition      = space* 'unique'i (space+ ('key'i | 'index'i))? options >StartUnique %EndUnique :> [,)] when NotEnclosedInParentheses;
  index_definition       = space* ('index'i | 'key'i) options >StartIndex %EndIndex :> [,)] when NotEnclosedInParentheses;

  main := space* create_table space+ table_name space+ lparens (column_definition | primary_key_definition | unique_definition | index_definition)+ rparens;
}%%
=end

class CreateTable
  class << self
    def quote(ident)
      @reserved_words ||= (IO.readlines(File.expand_path('../create_table/mysql_reserved.txt', __FILE__)) + IO.readlines(File.expand_path('../create_table/pg_reserved.txt', __FILE__))).map(&:chomp).sort.uniq
      if @reserved_words.include?(ident.upcase)
        QUOTE_IDENT + ident + QUOTE_IDENT
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

  def primary_key=(column_name)
    if column_name.nil?
      @primary_key = nil
    else
      @primary_key = column_name.to_s
      unless indexes[@primary_key]
        i = Index.new self
        i.column_names = @primary_key
      end
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

  def create_table_sql
    x = []
    x << 'CREATE'
    x << 'TEMPORARY' if temporary
    x << %{TABLE #{quoted_table_name} (}
    x << columns.map(&:to_sql).join(', ')
    x << ')'
    x.join ' '
  end

  def create_indexes_sql
    indexes.map(&:to_sql).compact
  end

  def to_sql
    [create_table_sql] + create_indexes_sql
  end

  def to_mysql(ansi_mode = false)
    if ansi_mode
      to_sql
    else
      to_sql.map { |stmt| stmt.gsub(QUOTE_IDENT, BACKTICK) }
    end
  end

  def to_postgresql
    to_sql
  end

  def to_sqlite3
    [create_table_sql.gsub(/auto_?increment/i, 'AUTOINCREMENT')] + create_indexes_sql
  end

  def quoted_table_name
    CreateTable.quote table_name
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
