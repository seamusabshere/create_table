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

  action StartDataType {
    $stderr.puts "StartDataType(#{p})" if ENV['VERBOSE'] == 'true'
    start_data_type = p
  }
  action EndDataType {
    end_data_type ||= p
    $stderr.puts "EndDataType(#{start_data_type}, #{end_data_type}, p=#{p}) - #{read(data, start_data_type, end_data_type).inspect}" if ENV['VERBOSE'] == 'true'
    self.data_type = read(data, start_data_type, end_data_type)
  }

  action StartPrimaryKey {
    $stderr.puts "StartPrimaryKey(#{p})" if ENV['VERBOSE'] == 'true'
    start_primary_key = p
  }
  action PrimaryKey {
    $stderr.puts "PrimaryKey(#{p})" if ENV['VERBOSE'] == 'true'
    primary_key!
    end_data_type ||= start_primary_key
  }

  action StartUnique {
    $stderr.puts "StartUnique(p=#{p})" if ENV['VERBOSE'] == 'true'
    start_unique = p - 4
  }
  action Unique {
    $stderr.puts "Unique(p=#{p})" if ENV['VERBOSE'] == 'true'
    unique!
    end_data_type ||= start_unique
  }

  action StartAutoincrement {
    $stderr.puts "StartAutoincrement(#{p})" if ENV['VERBOSE'] == 'true'
    start_autoincrement = p
  }
  action Autoincrement {
    $stderr.puts "Autoincrement(#{p})" if ENV['VERBOSE'] == 'true'
    autoincrement!
    end_data_type ||= start_autoincrement
  }

  name            = quote ident >StartName %EndName quote;
  primary_key     = ('primary'i space+ 'key'i) >StartPrimaryKey @PrimaryKey;
  autoincrement   = ('auto'i '_'? 'increment'i) >StartAutoincrement @Autoincrement;
  unique          = 'uniq'i %StartUnique 'ue'i @Unique;
  data_type       = any+ space*;

  main := space* name space+ data_type >StartDataType primary_key? unique? autoincrement? %EndDataType;
}%%
=end

class CreateTable
  class Column
    include Parser

    attr_reader :parent
    attr_reader :name
    attr_accessor :data_type

    def initialize(parent)
      @parent = parent
      parent.columns << self
    end

    def name=(name)
      @name = name
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

    def primary_key
      parent.primary_key == self
    end

    def primary_key!
      parent.primary_key = name
    end

    def unique
      if index = parent.indexes[name]
        index.unique
      else
        false
      end
    end

    def named_unique
      unique and parent.indexes[name].name
    end

    def unique!
      parent.add_unique name
    end

    def autoincrement!
      @autoincrement = true
    end

    def autoincrement
      @autoincrement == true
    end

    # @private
    def column_names
      [name]
    end

    def quoted_name
      CreateTable.quote name
    end

    def to_sql
      [quoted_name, options].join ' '
    end

    def options
      parts = []
      parts << data_type
      if primary_key
        parts << 'PRIMARY KEY'
      end
      if unique and not named_unique
        parts << 'UNIQUE'
      end
      if autoincrement
        parts << 'AUTO_INCREMENT'
      end
      parts.join ' '
    end

  end
end
