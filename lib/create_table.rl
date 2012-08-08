require 'create_table/version'
require 'create_table/column'
require 'create_table/index'
require 'create_table/unique'

# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin
%%{
  machine create_table_parser;

  action StartTableName {
    start_table_name = p
  }
  action EndTableName {
    self.table_name = read(data, start_table_name, p)
    start_table_name = nil
  }
  action StartColumnName {
    $stderr.puts "StartColumnName(#{p})" if ENV['VERBOSE'] == 'true'
    start_column_name = p
  }
  action EndColumnName {
    $stderr.puts "EndColumnName(#{start_column_name}, #{p}) - #{read(data, start_column_name, p).inspect}" if ENV['VERBOSE'] == 'true'
    column_name = read(data, start_column_name, p)
    last_col = add_column column_name
    start_column_name = nil
  }
  action StartColumnOptions {
    $stderr.puts "StartColumnOptions(#{p})" if ENV['VERBOSE'] == 'true'
    start_column_options = p
  }
  action EndColumnOptions {
    $stderr.puts "EndColumnOptions(#{start_column_options}, #{p}) - #{read(data, start_column_options, p).inspect}" if ENV['VERBOSE'] == 'true'
    last_col.options = read(data, start_column_options, p)
    last_col = nil
    start_column_options = nil
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
    add_unique read(data, start_unique, p)
    start_unique = nil
  }
  action StartIndexName {
    $stderr.puts "StartIndexName(#{p})" if ENV['VERBOSE'] == 'true'
    start_index_name = p
  }
  action EndIndexName {
    $stderr.puts "EndIndexName(#{start_index_name}, #{p}) - #{read(data, start_index_name, p).inspect}" if ENV['VERBOSE'] == 'true'
    index_name = read(data, start_index_name, p)
    last_index = add_index nil, index_name
    start_index_name = nil
  }
  action StartIndexColumnName {
    $stderr.puts "StartIndexColumnName(#{p})" if ENV['VERBOSE'] == 'true'
    start_index_column_name = p
  }
  action EndIndexColumnName {
    $stderr.puts "EndIndexColumnName(#{start_index_column_name}, #{p}) - #{read(data, start_index_column_name, p).inspect}" if ENV['VERBOSE'] == 'true'
    column_name = read(data, start_index_column_name, p)
    last_index.column_name = column_name
    last_index = nil
    start_index_column_name = nil
  }

  # conditions
  action NotEnclosedInParentheses {
    r = (parens == 0)
    $stderr.puts "outside => #{r.inspect} (parens = #{parens.inspect})" if ENV['VERBOSE'] == 'true'
    r
  }

  ident                  = [_a-zA-Z][_a-zA-Z0-9]*;
  quote_ident            = ["`];
  lparens                = space* '(' space*;
  rparens                = space* ')' space*;
  parens_counter         = ( any | '(' @{parens+=1} | ')' @{parens-=1} )*;
  create_table           = 'create'i space+ ('temporary'i space+ @{@temporary=true})? 'table'i;
  table_name             = quote_ident? ident >StartTableName %EndTableName quote_ident?;
  column_name            = quote_ident? ident >StartColumnName %EndColumnName quote_ident?;
  column_options         = any+ & parens_counter >StartColumnOptions %EndColumnOptions :> [,)] when NotEnclosedInParentheses;
  column_definition      = space* column_name space+ column_options;
  primary_key_definition = space* 'primary'i space+ 'key'i lparens quote_ident? ident >StartPrimaryKey %EndPrimaryKey quote_ident? rparens;
  unique_definition      = space* 'unique'i (space+ 'key'i)? lparens quote_ident? ident >StartUnique %EndUnique quote_ident? rparens;
  index_definition       = space* ('index'i | 'key'i) space+ quote_ident? ident >StartIndexName %EndIndexName quote_ident? lparens quote_ident? ident >StartIndexColumnName %EndIndexColumnName quote_ident? rparens;

  main := space* create_table space+ table_name space+ lparens (column_definition | primary_key_definition | unique_definition | index_definition)+ rparens;
}%%
=end

class CreateTable
  class << self
    def quote_ident(ident)
      @reserved_words ||= (IO.readlines(File.expand_path('../create_table/mysql_reserved.txt', __FILE__)) + IO.readlines(File.expand_path('../create_table/pg_reserved.txt', __FILE__))).map(&:chomp).sort.uniq
      if @reserved_words.include?(ident.upcase)
        QUOTE_IDENT + ident + QUOTE_IDENT
      else
        ident
      end
    end
  end

  # http://ostermiller.org/findcomment.html
  COMMENT = %r{/\*(?:.|[\r\n])*?\*/}m
  QUOTE_IDENT = '"'

  attr_reader :columns
  attr_reader :indexes
  attr_reader :uniques

  attr_accessor :table_name
  attr_accessor :temporary
  
  def initialize(sql = nil)
    if sql
      parse sql
    else
      clear
    end
  end

  def primary_key=(column_name)
    unless indexes.any? { |i| i.column_name == column_name }
      indexes << Index.new(self, column_name)
    end
    @primary_key = column_name
  end

  def primary_key
    if @primary_key
      indexes.detect { |i| i.column_name == @primary_key }
    end
  end

  def add_column(column_name, options = '')
    c = Column.new self, column_name, options
    columns << c
    c
  end

  def add_unique(column_name, index_name = nil)
    u = Unique.new self, column_name, index_name
    uniques << u
    indexes << u
    u
  end

  def add_index(column_name, index_name = nil)
    i = Index.new self, column_name, index_name
    indexes << i
    i
  end

  def to_sql
    parts = []
    parts << 'CREATE'
    parts << 'TEMPORARY' if temporary
    parts << %{TABLE #{quoted_table_name} (}
    parts << (columns + indexes - [primary_key] - uniques).map(&:to_sql).join(', ')
    parts << ')'
    parts.join ' '
  end

  def quoted_table_name
    CreateTable.quote_ident table_name
  end

  def parse(sql)
    clear
    data = sql.gsub(COMMENT, '').unpack('c*')

    %% write data;
    # % (this fixes syntax highlighting)
    
    parens = 0
    p = item = 0
    pe = eof = data.length

    %% write init;
    # % (this fixes syntax highlighting)

    %% write exec;
    # % (this fixes syntax highlighting)
  end

  private

  def read(data, s, p)
    data[s, p-s].pack('c*').strip
  end

  def clear
    @columns = []
    @indexes = []
    @uniques = []
    self.table_name = nil
    self.temporary = nil
  end
end
