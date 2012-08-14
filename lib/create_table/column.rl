# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin
%%{
  machine parser;

  include "common.rl";

  action StartName         { start_name = p                                               }
  action EndName           { self.name = read(data, start_name, p)                        }

  action StartDataType     { start_data_type = p                                          }
  action EndDataType       {
                             end_data_type ||= p
                             self.data_type = read(data, start_data_type, end_data_type)
                           }

  action MarkPrimaryKey    { mark_primary_key = p - 1                                     }
  action PrimaryKey        {
                             primary_key!
                             end_data_type ||= mark_primary_key
                           }

  action MarkUnique        { mark_unique = p - 5                                          }
  action Unique            {
                             unique!
                             end_data_type ||= mark_unique
                           }

  action MarkAutoincrement { mark_autoincrement = p - 1                                   }
  action Autoincrement     {
                             autoincrement!
                             end_data_type ||= mark_autoincrement
                           }

  action MarkNotNull       { mark_not_null = p - 4                                        }
  action Null              {
                             mark_not_null ||= nil
                             if mark_not_null
                               self.null = false
                               end_data_type ||= mark_not_null
                             else
                               self.null = true
                               end_data_type ||= p - 4
                             end
                           }

  action MarkDefault       { mark_default = p - 1                                         }
  action StartDefault      { start_default = p                                            }
  action EndDefault        {
                             self.default = read(data, start_default, p).sub(/['"]$/, '').gsub(/(['"])\1/, '\1')
                             end_data_type ||= mark_default
                           }

  # conditions
  action NotEnclosedInQuotes { (quote_value % 2) == 0 }
  action EnclosedInQuotes    { (quote_value % 2) == 1 }

  name            = quote_ident ident >StartName %EndName quote_ident;
  primary_key     = ('primary'i space+ 'key'i) >MarkPrimaryKey @PrimaryKey;
  autoincrement   = ('auto'i '_'? 'increment'i) >MarkAutoincrement @Autoincrement;
  unique          = 'uniq'i %MarkUnique 'ue'i @Unique;
  default         = (('default'i space+ quote_value?) & quote_value_counter) >MarkDefault ((any+ >StartDefault %EndDefault) & quote_value_counter) :> (space* when NotEnclosedInQuotes) | (quote_value when EnclosedInQuotes);
  _null           = ('not'i %MarkNotNull)? space+ 'null'i @Null;
  data_type       = any+;

  main := space* name space+ data_type >StartDataType _null? default? primary_key? unique? autoincrement? %EndDataType;
}%%
=end

require 'create_table/column/to_sql'

class CreateTable
  class Column
    BLANK_STRING = ''

    include Parser

    attr_reader :parent
    attr_reader :name
    attr_reader :data_type
    attr_writer :default
    attr_writer :null

    def initialize(parent)
      @parent = parent
      parent.columns << self
    end

    def name=(name)
      @name = name
    end

    def data_type=(str)
      case str
      when /serial/i
        autoincrement!
        @data_type = 'INTEGER'
      else
        @data_type = str
      end
    end

    def default
      if defined?(@default)
        @default
      elsif primary_key and data_type =~ /char/i
        BLANK_STRING
      end
    end

    def null
      if defined?(@null)
        @null
      elsif primary_key
        false
      else
        true
      end
    end

    alias :allow_null :null

    def primary_key
      parent.primary_key == self
    end

    def primary_key!
      parent.primary_key = name
    end

    def unique
      if primary_key
        true
      elsif index = parent.indexes[name]
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

    def index!
      parent.add_index name
    end

    def indexed
      primary_key or !!parent.indexes[name]
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

    def parse(str)
      data = Parser.remove_comments(str).strip.unpack('c*')
      %% write data;
      # % (this fixes syntax highlighting)
      parens = quote_value = 0
      p = item = 0
      pe = eof = data.length
      %% write init;
      # % (this fixes syntax highlighting)
      %% write exec;
      # % (this fixes syntax highlighting)
      self
    end
  end
end
