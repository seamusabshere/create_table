require 'create_table/version'
require 'create_table/column'

# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin
%%{
  machine create_table_parser;

  action StartTableName {
    s = p
  }
  action EndTableName {
    self.table_name = read(s, p)
    s = nil
  }
  action StartColumnName {
    $stderr.puts "n_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  }
  action EndColumnName {
    $stderr.puts "n_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col = add_column read(s, p)
    s = nil
  }
  action StartColumnOptions {
    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  }
  action EndColumnOptions {
    $stderr.puts "o_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col.options = read(s, p)
    s = nil
  }

  # conditions
  action NotEnclosedInParentheses {
    r = (parentheses == 0)
    $stderr.puts "outside(#{r.inspect})" if ENV['VERBOSE'] == 'true'
    r
  }

  ident               = [_a-zA-Z][_a-zA-Z0-9]*;
  quote_ident         = ["`];
  parentheses_counter = ( any | '(' @{parentheses+=1} | ')' @{parentheses-=1} )*;
  create_table        = 'create'i space+ ('temporary'i space+ @{@temporary=true})? 'table'i;
  table_name          = quote_ident? ident >StartTableName %EndTableName quote_ident?;
  column_name         = quote_ident? ident >StartColumnName %EndColumnName quote_ident?;
  column_options      = any+ & parentheses_counter >StartColumnOptions %EndColumnOptions :> [,)] when NotEnclosedInParentheses;
  column_definition   = space* column_name space+ column_options;

  main := space* create_table space+ table_name space+ '(' column_definition+ ')';
}%%
=end

class CreateTable
  class << self
    def quote_ident(ident)
      @reserved_words ||= (IO.readlines(File.expand_path('../create_table/mysql_reserved.txt', __FILE__)) + IO.readlines(File.expand_path('../create_table/pg_reserved.txt', __FILE__))).map(&:chomp).sort.uniq
      if @reserved_words.include?(ident.upcase)
        '"' + ident + '"'
      else
        ident
      end
    end
  end

  attr_reader :data
  attr_reader :columns

  attr_accessor :table_name
  attr_accessor :temporary
  
  def initialize(sql = nil)
    @columns = []
    if sql
      @data = sql.unpack('c*')
      parse!
    end
  end

  def add_column(name, options = '')
    c = Column.new(self, name, options)
    columns << c
    c
  end

  def to_sql
    parts = []
    parts << 'CREATE'
    parts << 'TEMPORARY' if temporary
    parts << %{TABLE #{quoted_table_name} (}
    parts << columns.map(&:to_sql).join(', ')
    parts << ')'
    parts.join ' '
  end

  def quoted_table_name
    CreateTable.quote_ident table_name
  end

  private

  def read(s, p)
    data[s, p-s].pack('c*').strip
  end

  def parse!
    %% write data;
    # % (this fixes syntax highlighting)
    
    parentheses = 0
    p = item = 0
    pe = eof = data.length

    %% write init;
    # % (this fixes syntax highlighting)

    %% write exec;
    # % (this fixes syntax highlighting)
  end
end
