# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin
%%{
  machine parser;

  include "common.rl";

  action StartName {
    start_name = p
  }
  action EndName {
    self.name = read(data, start_name, p)
    start_name = nil
  }
  action StartColumnName {
    $stderr.puts "StartColumnName(#{p})" if ENV['VERBOSE'] == 'true'
    start_column_name = p
  }
  action EndColumnName {
    $stderr.puts "EndColumnName(#{start_column_name}, #{p}) - #{read(data, start_column_name, p).inspect}" if ENV['VERBOSE'] == 'true'
    column_names << read(data, start_column_name, p)
    start_column_name = nil
  }

  name                   = space* quote ident >StartName %EndName quote;
  column_name            = space* quote ident >StartColumnName %EndColumnName quote :> [,)];

  main := name? lparens column_name+ rparens;
}%%
=end

class CreateTable
  class Index
    include Parser

    attr_reader :parent
    attr_reader :column_names
    attr_accessor :name
    
    def initialize(parent)
      @parent = parent
      @column_names = []
      parent.indexes << self
    end

    def unique
      false
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

    def column_names=(column_names)
      @column_names = [column_names].compact.flatten
    end

    def to_sql
      return if primary_key
      parts = []
      parts << 'CREATE'
      parts << 'UNIQUE' if (unique and name)
      parts << 'INDEX'
      parts += [ quoted_name, 'ON', parent.quoted_table_name, '(', quoted_column_names, ')' ]
      parts.join ' '
    end

    def primary_key
      if pk = parent.primary_key
        pk.column_names == column_names
      end
    end

    def quoted_name
      if name
        CreateTable.quote name
      else
        "index_#{parent.table_name}_on_#{name}"
      end
    end

    def quoted_column_names
      column_names.map do |column_name|
        CreateTable.quote column_name
      end.join(', ')
    end
  end
end
