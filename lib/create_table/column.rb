
# line 1 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin

# line 68 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"

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
      
# line 115 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.rb"
class << self
	attr_accessor :_parser_actions
	private :_parser_actions, :_parser_actions=
end
self._parser_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 14, 1, 
	15, 2, 0, 14, 2, 3, 5, 2, 
	3, 9, 2, 3, 13, 2, 11, 15, 
	2, 13, 14, 2, 14, 0, 2, 14, 
	5, 2, 14, 9, 2, 15, 4, 2, 
	15, 5, 2, 15, 7, 2, 15, 9
]

class << self
	attr_accessor :_parser_cond_offsets
	private :_parser_cond_offsets, :_parser_cond_offsets=
end
self._parser_cond_offsets = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 2, 4, 6, 
	8, 10, 12, 14, 16, 18, 20, 22, 
	24, 26, 28, 30, 32, 34, 36, 38, 
	40, 42, 44, 46, 48, 50, 52, 54, 
	56, 58, 60, 62, 64, 66, 68, 70, 
	72, 74, 76, 78, 80, 82, 84, 86, 
	88, 92, 92, 96, 100, 100, 100, 104, 
	108, 112, 116, 120, 124, 128, 132, 136, 
	138
]

class << self
	attr_accessor :_parser_cond_lengths
	private :_parser_cond_lengths, :_parser_cond_lengths=
end
self._parser_cond_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	4, 0, 4, 4, 0, 0, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 2, 
	2
]

class << self
	attr_accessor :_parser_cond_keys
	private :_parser_cond_keys, :_parser_cond_keys=
end
self._parser_cond_keys = [
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	9, 13, 32, 32, 34, 34, 39, 39, 
	34, 34, 39, 39, 34, 34, 39, 39, 
	0
]

class << self
	attr_accessor :_parser_cond_spaces
	private :_parser_cond_spaces, :_parser_cond_spaces=
end
self._parser_cond_spaces = [
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	0, 0, 1, 1, 0, 0, 1, 1, 
	0, 0, 1, 1, 0, 0, 1, 1, 
	0, 0, 1, 1, 0, 0, 1, 1, 
	0, 0, 1, 1, 0, 0, 1, 1, 
	0, 0, 1, 1, 0, 0, 1, 1, 
	0, 0, 1, 1, 0, 0, 1, 1, 
	1, 1, 1, 1, 0
]

class << self
	attr_accessor :_parser_key_offsets
	private :_parser_key_offsets, :_parser_key_offsets=
end
self._parser_key_offsets = [
	0, 0, 9, 14, 25, 28, 30, 32, 
	34, 37, 39, 41, 43, 45, 47, 49, 
	51, 53, 55, 57, 59, 61, 63, 65, 
	67, 70, 75, 77, 79, 81, 83, 85, 
	87, 89, 93, 97, 100, 125, 150, 175, 
	202, 229, 254, 279, 306, 333, 360, 387, 
	414, 439, 466, 493, 518, 547, 574, 599, 
	626, 651, 678, 705, 732, 759, 786, 813, 
	840, 867, 895, 920, 949, 976, 1003, 1030, 
	1057, 1082, 1111, 1138, 1163, 1192, 1219, 1244, 
	1269, 1298, 1298, 1329, 1360, 1364, 1366, 1395, 
	1424, 1453, 1482, 1511, 1540, 1573, 1604, 1633, 
	1658
]

class << self
	attr_accessor :_parser_trans_keys
	private :_parser_trans_keys, :_parser_trans_keys=
end
self._parser_trans_keys = [
	32, 34, 96, 9, 13, 65, 90, 95, 
	122, 95, 65, 90, 97, 122, 32, 34, 
	96, 9, 13, 48, 57, 65, 90, 95, 
	122, 32, 9, 13, 85, 117, 84, 116, 
	79, 111, 73, 95, 105, 78, 110, 67, 
	99, 82, 114, 69, 101, 77, 109, 69, 
	101, 78, 110, 84, 116, 73, 105, 82, 
	114, 73, 105, 77, 109, 65, 97, 82, 
	114, 89, 121, 32, 9, 13, 32, 75, 
	107, 9, 13, 69, 101, 89, 121, 78, 
	110, 73, 105, 81, 113, 85, 117, 69, 
	101, 78, 84, 110, 116, 69, 78, 101, 
	110, 32, 9, 13, 32, 65, 68, 78, 
	80, 85, 97, 100, 110, 112, 117, 802, 
	807, 1058, 1063, -128, 8, 9, 13, 14, 
	33, 35, 38, 40, 127, 32, 65, 68, 
	78, 80, 85, 97, 100, 110, 112, 117, 
	802, 807, 1058, 1063, -128, 8, 9, 13, 
	14, 33, 35, 38, 40, 127, 32, 65, 
	68, 78, 80, 85, 97, 100, 110, 112, 
	117, 802, 807, 1058, 1063, -128, 8, 9, 
	13, 14, 33, 35, 38, 40, 127, 32, 
	65, 68, 69, 78, 80, 85, 97, 100, 
	101, 110, 112, 117, 802, 807, 1058, 1063, 
	-128, 8, 9, 13, 14, 33, 35, 38, 
	40, 127, 32, 65, 68, 70, 78, 80, 
	85, 97, 100, 102, 110, 112, 117, 802, 
	807, 1058, 1063, -128, 8, 9, 13, 14, 
	33, 35, 38, 40, 127, 32, 65, 68, 
	78, 80, 85, 97, 100, 110, 112, 117, 
	802, 807, 1058, 1063, -128, 8, 9, 13, 
	14, 33, 35, 38, 40, 127, 32, 65, 
	68, 78, 80, 85, 97, 100, 110, 112, 
	117, 802, 807, 1058, 1063, -128, 8, 9, 
	13, 14, 33, 35, 38, 40, 127, 32, 
	65, 68, 78, 79, 80, 85, 97, 100, 
	110, 111, 112, 117, 802, 807, 1058, 1063, 
	-128, 8, 9, 13, 14, 33, 35, 38, 
	40, 127, 32, 65, 68, 78, 80, 84, 
	85, 97, 100, 110, 112, 116, 117, 802, 
	807, 1058, 1063, -128, 8, 9, 13, 14, 
	33, 35, 38, 40, 127, 32, 65, 68, 
	78, 80, 82, 85, 97, 100, 110, 112, 
	114, 117, 802, 807, 1058, 1063, -128, 8, 
	9, 13, 14, 33, 35, 38, 40, 127, 
	32, 65, 68, 73, 78, 80, 85, 97, 
	100, 105, 110, 112, 117, 802, 807, 1058, 
	1063, -128, 8, 9, 13, 14, 33, 35, 
	38, 40, 127, 32, 65, 68, 77, 78, 
	80, 85, 97, 100, 109, 110, 112, 117, 
	802, 807, 1058, 1063, -128, 8, 9, 13, 
	14, 33, 35, 38, 40, 127, 32, 65, 
	68, 78, 80, 85, 97, 100, 110, 112, 
	117, 802, 807, 1058, 1063, -128, 8, 9, 
	13, 14, 33, 35, 38, 40, 127, 32, 
	65, 68, 78, 80, 82, 85, 97, 100, 
	110, 112, 114, 117, 802, 807, 1058, 1063, 
	-128, 8, 9, 13, 14, 33, 35, 38, 
	40, 127, 32, 65, 68, 78, 80, 85, 
	89, 97, 100, 110, 112, 117, 121, 802, 
	807, 1058, 1063, -128, 8, 9, 13, 14, 
	33, 35, 38, 40, 127, 32, 65, 68, 
	78, 80, 85, 97, 100, 110, 112, 117, 
	802, 807, 1058, 1063, -128, 8, 9, 13, 
	14, 33, 35, 38, 40, 127, 32, 65, 
	68, 73, 78, 79, 80, 85, 97, 100, 
	105, 110, 111, 112, 117, 802, 807, 1058, 
	1063, -128, 8, 9, 13, 14, 33, 35, 
	38, 40, 127, 32, 65, 68, 78, 80, 
	81, 85, 97, 100, 110, 112, 113, 117, 
	802, 807, 1058, 1063, -128, 8, 9, 13, 
	14, 33, 35, 38, 40, 127, 32, 65, 
	68, 78, 80, 85, 97, 100, 110, 112, 
	117, 802, 807, 1058, 1063, -128, 8, 9, 
	13, 14, 33, 35, 38, 40, 127, 32, 
	65, 68, 69, 78, 80, 85, 97, 100, 
	101, 110, 112, 117, 802, 807, 1058, 1063, 
	-128, 8, 9, 13, 14, 33, 35, 38, 
	40, 127, 32, 65, 68, 78, 80, 85, 
	97, 100, 110, 112, 117, 802, 807, 1058, 
	1063, -128, 8, 9, 13, 14, 33, 35, 
	38, 40, 127, 32, 65, 68, 75, 78, 
	80, 85, 97, 100, 107, 110, 112, 117, 
	802, 807, 1058, 1063, -128, 8, 9, 13, 
	14, 33, 35, 38, 40, 127, 32, 65, 
	68, 69, 78, 80, 85, 97, 100, 101, 
	110, 112, 117, 802, 807, 1058, 1063, -128, 
	8, 9, 13, 14, 33, 35, 38, 40, 
	127, 32, 65, 68, 78, 80, 85, 89, 
	97, 100, 110, 112, 117, 121, 802, 807, 
	1058, 1063, -128, 8, 9, 13, 14, 33, 
	35, 38, 40, 127, 32, 65, 68, 78, 
	79, 80, 85, 97, 100, 110, 111, 112, 
	117, 802, 807, 1058, 1063, -128, 8, 9, 
	13, 14, 33, 35, 38, 40, 127, 32, 
	65, 68, 76, 78, 80, 85, 97, 100, 
	108, 110, 112, 117, 802, 807, 1058, 1063, 
	-128, 8, 9, 13, 14, 33, 35, 38, 
	40, 127, 32, 65, 68, 76, 78, 80, 
	85, 97, 100, 108, 110, 112, 117, 802, 
	807, 1058, 1063, -128, 8, 9, 13, 14, 
	33, 35, 38, 40, 127, 32, 65, 68, 
	78, 80, 84, 85, 97, 100, 110, 112, 
	116, 117, 802, 807, 1058, 1063, -128, 8, 
	9, 13, 14, 33, 35, 38, 40, 127, 
	32, 65, 68, 78, 79, 80, 85, 97, 
	100, 110, 111, 112, 117, 802, 807, 1058, 
	1063, -128, 8, 9, 13, 14, 33, 35, 
	38, 40, 127, 32, 65, 68, 73, 78, 
	80, 85, 95, 97, 100, 105, 110, 112, 
	117, 802, 807, 1058, 1063, -128, 8, 9, 
	13, 14, 33, 35, 38, 40, 127, 32, 
	65, 68, 78, 80, 85, 97, 100, 110, 
	112, 117, 802, 807, 1058, 1063, -128, 8, 
	9, 13, 14, 33, 35, 38, 40, 127, 
	32, 65, 67, 68, 78, 79, 80, 85, 
	97, 99, 100, 110, 111, 112, 117, 802, 
	807, 1058, 1063, -128, 8, 9, 13, 14, 
	33, 35, 38, 40, 127, 32, 65, 68, 
	78, 80, 82, 85, 97, 100, 110, 112, 
	114, 117, 802, 807, 1058, 1063, -128, 8, 
	9, 13, 14, 33, 35, 38, 40, 127, 
	32, 65, 68, 69, 78, 80, 85, 97, 
	100, 101, 110, 112, 117, 802, 807, 1058, 
	1063, -128, 8, 9, 13, 14, 33, 35, 
	38, 40, 127, 32, 65, 68, 77, 78, 
	80, 85, 97, 100, 109, 110, 112, 117, 
	802, 807, 1058, 1063, -128, 8, 9, 13, 
	14, 33, 35, 38, 40, 127, 32, 65, 
	68, 69, 78, 80, 85, 97, 100, 101, 
	110, 112, 117, 802, 807, 1058, 1063, -128, 
	8, 9, 13, 14, 33, 35, 38, 40, 
	127, 32, 65, 68, 78, 80, 85, 97, 
	100, 110, 112, 117, 802, 807, 1058, 1063, 
	-128, 8, 9, 13, 14, 33, 35, 38, 
	40, 127, 32, 65, 68, 78, 79, 80, 
	84, 85, 97, 100, 110, 111, 112, 116, 
	117, 802, 807, 1058, 1063, -128, 8, 9, 
	13, 14, 33, 35, 38, 40, 127, 32, 
	65, 68, 73, 78, 80, 85, 97, 100, 
	105, 110, 112, 117, 802, 807, 1058, 1063, 
	-128, 8, 9, 13, 14, 33, 35, 38, 
	40, 127, 32, 65, 68, 78, 80, 85, 
	97, 100, 110, 112, 117, 802, 807, 1058, 
	1063, -128, 8, 9, 13, 14, 33, 35, 
	38, 40, 127, 32, 65, 68, 76, 78, 
	80, 84, 85, 97, 100, 108, 110, 112, 
	116, 117, 802, 807, 1058, 1063, -128, 8, 
	9, 13, 14, 33, 35, 38, 40, 127, 
	32, 65, 68, 78, 80, 84, 85, 97, 
	100, 110, 112, 116, 117, 802, 807, 1058, 
	1063, -128, 8, 9, 13, 14, 33, 35, 
	38, 40, 127, 32, 65, 68, 78, 80, 
	85, 97, 100, 110, 112, 117, 802, 807, 
	1058, 1063, -128, 8, 9, 13, 14, 33, 
	35, 38, 40, 127, 32, 65, 68, 78, 
	80, 85, 97, 100, 110, 112, 117, 802, 
	807, 1058, 1063, -128, 8, 9, 13, 14, 
	33, 35, 38, 40, 127, 33, 65, 68, 
	78, 80, 85, 97, 100, 110, 112, 117, 
	288, 544, 802, 807, 1058, 1063, -128, 8, 
	14, 31, 35, 38, 40, 127, 265, 269, 
	521, 525, 33, 65, 68, 78, 79, 80, 
	85, 97, 100, 110, 111, 112, 117, 288, 
	544, 802, 807, 1058, 1063, -128, 8, 14, 
	31, 35, 38, 40, 127, 265, 269, 521, 
	525, 33, 65, 68, 78, 80, 84, 85, 
	97, 100, 110, 112, 116, 117, 288, 544, 
	802, 807, 1058, 1063, -128, 8, 14, 31, 
	35, 38, 40, 127, 265, 269, 521, 525, 
	65, 85, 97, 117, 65, 97, 33, 65, 
	68, 78, 80, 85, 97, 100, 110, 112, 
	117, 288, 544, 802, 807, 1058, 1063, -128, 
	8, 14, 31, 35, 38, 40, 127, 265, 
	269, 521, 525, 33, 65, 68, 78, 80, 
	85, 97, 100, 110, 112, 117, 288, 544, 
	802, 807, 1058, 1063, -128, 8, 14, 31, 
	35, 38, 40, 127, 265, 269, 521, 525, 
	33, 65, 68, 78, 80, 85, 97, 100, 
	110, 112, 117, 288, 544, 802, 807, 1058, 
	1063, -128, 8, 14, 31, 35, 38, 40, 
	127, 265, 269, 521, 525, 33, 65, 68, 
	78, 80, 85, 97, 100, 110, 112, 117, 
	288, 544, 802, 807, 1058, 1063, -128, 8, 
	14, 31, 35, 38, 40, 127, 265, 269, 
	521, 525, 33, 65, 68, 78, 80, 85, 
	97, 100, 110, 112, 117, 288, 544, 802, 
	807, 1058, 1063, -128, 8, 14, 31, 35, 
	38, 40, 127, 265, 269, 521, 525, 33, 
	65, 68, 78, 80, 85, 97, 100, 110, 
	112, 117, 288, 544, 802, 807, 1058, 1063, 
	-128, 8, 14, 31, 35, 38, 40, 127, 
	265, 269, 521, 525, 33, 65, 68, 73, 
	78, 79, 80, 85, 97, 100, 105, 110, 
	111, 112, 117, 288, 544, 802, 807, 1058, 
	1063, -128, 8, 14, 31, 35, 38, 40, 
	127, 265, 269, 521, 525, 33, 65, 68, 
	78, 80, 81, 85, 97, 100, 110, 112, 
	113, 117, 288, 544, 802, 807, 1058, 1063, 
	-128, 8, 14, 31, 35, 38, 40, 127, 
	265, 269, 521, 525, 33, 65, 68, 78, 
	80, 85, 97, 100, 110, 112, 117, 288, 
	544, 802, 807, 1058, 1063, -128, 8, 14, 
	31, 35, 38, 40, 127, 265, 269, 521, 
	525, 32, 65, 68, 78, 80, 85, 97, 
	100, 110, 112, 117, 802, 807, 1058, 1063, 
	-128, 8, 9, 13, 14, 33, 35, 38, 
	40, 127, 32, 65, 68, 78, 80, 85, 
	97, 100, 110, 112, 117, 802, 807, 1058, 
	1063, -128, 8, 9, 13, 14, 33, 35, 
	38, 40, 127, 0
]

class << self
	attr_accessor :_parser_single_lengths
	private :_parser_single_lengths, :_parser_single_lengths=
end
self._parser_single_lengths = [
	0, 3, 1, 3, 1, 2, 2, 2, 
	3, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	1, 3, 2, 2, 2, 2, 2, 2, 
	2, 4, 4, 1, 15, 15, 15, 17, 
	17, 15, 15, 17, 17, 17, 17, 17, 
	15, 17, 17, 15, 19, 17, 15, 17, 
	15, 17, 17, 17, 17, 17, 17, 17, 
	17, 18, 15, 19, 17, 17, 17, 17, 
	15, 19, 17, 15, 19, 17, 15, 15, 
	17, 0, 19, 19, 4, 2, 17, 17, 
	17, 17, 17, 17, 21, 19, 17, 15, 
	15
]

class << self
	attr_accessor :_parser_range_lengths
	private :_parser_range_lengths, :_parser_range_lengths=
end
self._parser_range_lengths = [
	0, 3, 2, 4, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 1, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	6, 0, 6, 6, 0, 0, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 5, 
	5
]

class << self
	attr_accessor :_parser_index_offsets
	private :_parser_index_offsets, :_parser_index_offsets=
end
self._parser_index_offsets = [
	0, 0, 7, 11, 19, 22, 25, 28, 
	31, 35, 38, 41, 44, 47, 50, 53, 
	56, 59, 62, 65, 68, 71, 74, 77, 
	80, 83, 88, 91, 94, 97, 100, 103, 
	106, 109, 114, 119, 122, 143, 164, 185, 
	208, 231, 252, 273, 296, 319, 342, 365, 
	388, 409, 432, 455, 476, 501, 524, 545, 
	568, 589, 612, 635, 658, 681, 704, 727, 
	750, 773, 797, 818, 843, 866, 889, 912, 
	935, 956, 981, 1004, 1025, 1050, 1073, 1094, 
	1115, 1139, 1140, 1166, 1192, 1197, 1200, 1224, 
	1248, 1272, 1296, 1320, 1344, 1372, 1398, 1422, 
	1443
]

class << self
	attr_accessor :_parser_indicies
	private :_parser_indicies, :_parser_indicies=
end
self._parser_indicies = [
	0, 2, 2, 0, 3, 3, 1, 3, 
	3, 3, 1, 4, 5, 5, 4, 6, 
	6, 6, 1, 8, 8, 7, 9, 9, 
	1, 10, 10, 1, 11, 11, 1, 12, 
	13, 12, 1, 14, 14, 1, 15, 15, 
	1, 16, 16, 1, 17, 17, 1, 18, 
	18, 1, 19, 19, 1, 20, 20, 1, 
	21, 21, 1, 12, 12, 1, 22, 22, 
	1, 23, 23, 1, 24, 24, 1, 25, 
	25, 1, 26, 26, 1, 27, 27, 1, 
	28, 28, 1, 28, 29, 29, 28, 1, 
	30, 30, 1, 31, 31, 1, 32, 32, 
	1, 33, 33, 1, 34, 34, 1, 35, 
	35, 1, 36, 36, 1, 32, 10, 32, 
	10, 1, 36, 32, 36, 32, 1, 37, 
	37, 1, 39, 40, 41, 42, 43, 44, 
	40, 41, 42, 43, 44, 38, 38, 38, 
	38, 38, 39, 38, 38, 38, 1, 39, 
	40, 41, 45, 43, 44, 40, 41, 45, 
	43, 44, 38, 38, 38, 38, 38, 39, 
	38, 38, 38, 1, 39, 40, 41, 42, 
	43, 46, 40, 41, 42, 43, 46, 38, 
	38, 38, 38, 38, 39, 38, 38, 38, 
	1, 39, 40, 41, 47, 42, 43, 44, 
	40, 41, 47, 42, 43, 44, 38, 38, 
	38, 38, 38, 39, 38, 38, 38, 1, 
	39, 40, 41, 48, 42, 43, 44, 40, 
	41, 48, 42, 43, 44, 38, 38, 38, 
	38, 38, 39, 38, 38, 38, 1, 39, 
	49, 41, 42, 43, 44, 49, 41, 42, 
	43, 44, 38, 38, 38, 38, 38, 39, 
	38, 38, 38, 1, 39, 40, 41, 42, 
	43, 50, 40, 41, 42, 43, 50, 38, 
	38, 38, 38, 38, 39, 38, 38, 38, 
	1, 39, 40, 41, 42, 51, 43, 44, 
	40, 41, 42, 51, 43, 44, 38, 38, 
	38, 38, 38, 39, 38, 38, 38, 1, 
	39, 40, 41, 42, 43, 52, 44, 40, 
	41, 42, 43, 52, 44, 38, 38, 38, 
	38, 38, 39, 38, 38, 38, 1, 39, 
	40, 41, 42, 43, 53, 44, 40, 41, 
	42, 43, 53, 44, 38, 38, 38, 38, 
	38, 39, 38, 38, 38, 1, 39, 40, 
	41, 54, 42, 43, 44, 40, 41, 54, 
	42, 43, 44, 38, 38, 38, 38, 38, 
	39, 38, 38, 38, 1, 39, 40, 41, 
	55, 42, 43, 44, 40, 41, 55, 42, 
	43, 44, 38, 38, 38, 38, 38, 39, 
	38, 38, 38, 1, 39, 56, 41, 42, 
	43, 44, 56, 41, 42, 43, 44, 38, 
	38, 38, 38, 38, 39, 38, 38, 38, 
	1, 39, 40, 41, 42, 43, 57, 46, 
	40, 41, 42, 43, 57, 46, 38, 38, 
	38, 38, 38, 39, 38, 38, 38, 1, 
	39, 40, 41, 42, 43, 44, 58, 40, 
	41, 42, 43, 44, 58, 38, 38, 38, 
	38, 38, 39, 38, 38, 38, 1, 39, 
	40, 41, 59, 43, 44, 40, 41, 59, 
	43, 44, 38, 38, 38, 38, 38, 39, 
	38, 38, 38, 1, 39, 40, 41, 60, 
	42, 51, 43, 44, 40, 41, 60, 42, 
	51, 43, 44, 38, 38, 38, 38, 38, 
	39, 38, 38, 38, 1, 39, 40, 41, 
	42, 43, 61, 44, 40, 41, 42, 43, 
	61, 44, 38, 38, 38, 38, 38, 39, 
	38, 38, 38, 1, 39, 40, 41, 42, 
	43, 62, 40, 41, 42, 43, 62, 38, 
	38, 38, 38, 38, 39, 38, 38, 38, 
	1, 39, 40, 41, 63, 59, 43, 44, 
	40, 41, 63, 59, 43, 44, 38, 38, 
	38, 38, 38, 39, 38, 38, 38, 1, 
	64, 40, 41, 42, 43, 44, 40, 41, 
	42, 43, 44, 38, 38, 38, 38, 38, 
	64, 38, 38, 38, 1, 64, 40, 41, 
	65, 45, 43, 44, 40, 41, 65, 45, 
	43, 44, 38, 38, 38, 38, 38, 64, 
	38, 38, 38, 1, 39, 40, 41, 66, 
	42, 43, 44, 40, 41, 66, 42, 43, 
	44, 38, 38, 38, 38, 38, 39, 38, 
	38, 38, 1, 39, 40, 41, 42, 43, 
	44, 67, 40, 41, 42, 43, 44, 67, 
	38, 38, 38, 38, 38, 39, 38, 38, 
	38, 1, 39, 40, 41, 42, 51, 43, 
	68, 40, 41, 42, 51, 43, 68, 38, 
	38, 38, 38, 38, 39, 38, 38, 38, 
	1, 39, 40, 41, 69, 59, 43, 44, 
	40, 41, 69, 59, 43, 44, 38, 38, 
	38, 38, 38, 39, 38, 38, 38, 1, 
	39, 40, 41, 70, 42, 43, 44, 40, 
	41, 70, 42, 43, 44, 38, 38, 38, 
	38, 38, 39, 38, 38, 38, 1, 39, 
	40, 41, 59, 43, 71, 44, 40, 41, 
	59, 43, 71, 44, 38, 38, 38, 38, 
	38, 39, 38, 38, 38, 1, 39, 40, 
	41, 42, 72, 43, 44, 40, 41, 42, 
	72, 43, 44, 38, 38, 38, 38, 38, 
	39, 38, 38, 38, 1, 39, 40, 41, 
	73, 42, 43, 44, 74, 40, 41, 73, 
	42, 43, 44, 38, 38, 38, 38, 38, 
	39, 38, 38, 38, 1, 39, 40, 41, 
	75, 43, 44, 40, 41, 75, 43, 44, 
	38, 38, 38, 38, 38, 39, 38, 38, 
	38, 1, 39, 40, 76, 41, 42, 51, 
	43, 44, 40, 76, 41, 42, 51, 43, 
	44, 38, 38, 38, 38, 38, 39, 38, 
	38, 38, 1, 39, 40, 41, 42, 43, 
	77, 44, 40, 41, 42, 43, 77, 44, 
	38, 38, 38, 38, 38, 39, 38, 38, 
	38, 1, 39, 40, 41, 78, 42, 43, 
	44, 40, 41, 78, 42, 43, 44, 38, 
	38, 38, 38, 38, 39, 38, 38, 38, 
	1, 39, 40, 41, 79, 42, 43, 44, 
	40, 41, 79, 42, 43, 44, 38, 38, 
	38, 38, 38, 39, 38, 38, 38, 1, 
	39, 40, 41, 80, 42, 43, 44, 40, 
	41, 80, 42, 43, 44, 38, 38, 38, 
	38, 38, 39, 38, 38, 38, 1, 39, 
	40, 41, 81, 43, 44, 40, 41, 81, 
	43, 44, 38, 38, 38, 38, 38, 39, 
	38, 38, 38, 1, 39, 40, 41, 42, 
	51, 43, 82, 44, 40, 41, 42, 51, 
	43, 82, 44, 38, 38, 38, 38, 38, 
	39, 38, 38, 38, 1, 39, 40, 41, 
	73, 42, 43, 44, 40, 41, 73, 42, 
	43, 44, 38, 38, 38, 38, 38, 39, 
	38, 38, 38, 1, 83, 40, 41, 42, 
	43, 44, 40, 41, 42, 43, 44, 38, 
	38, 38, 38, 38, 83, 38, 38, 38, 
	1, 39, 40, 41, 84, 59, 43, 71, 
	44, 40, 41, 84, 59, 43, 71, 44, 
	38, 38, 38, 38, 38, 39, 38, 38, 
	38, 1, 39, 40, 41, 42, 43, 85, 
	44, 40, 41, 42, 43, 85, 44, 38, 
	38, 38, 38, 38, 39, 38, 38, 38, 
	1, 86, 40, 41, 42, 43, 44, 40, 
	41, 42, 43, 44, 38, 38, 38, 38, 
	38, 86, 38, 38, 38, 1, 88, 89, 
	90, 91, 92, 93, 89, 90, 91, 92, 
	93, 94, 94, 94, 94, 87, 88, 87, 
	87, 87, 1, 95, 96, 97, 98, 99, 
	100, 96, 97, 98, 99, 100, 95, 101, 
	102, 102, 102, 102, 95, 95, 95, 95, 
	95, 101, 1, 1, 95, 96, 97, 98, 
	103, 99, 100, 96, 97, 98, 103, 99, 
	100, 95, 101, 102, 102, 102, 102, 95, 
	95, 95, 95, 95, 101, 1, 95, 96, 
	97, 98, 99, 104, 100, 96, 97, 98, 
	99, 104, 100, 95, 101, 102, 102, 102, 
	102, 95, 95, 95, 95, 95, 101, 1, 
	105, 106, 105, 106, 1, 105, 105, 1, 
	95, 96, 97, 98, 99, 100, 96, 97, 
	98, 99, 100, 107, 108, 102, 102, 102, 
	102, 95, 95, 95, 95, 107, 108, 1, 
	38, 40, 41, 45, 43, 44, 40, 41, 
	45, 43, 44, 39, 109, 38, 38, 38, 
	38, 38, 38, 38, 38, 39, 109, 1, 
	87, 96, 90, 91, 99, 100, 96, 90, 
	91, 99, 100, 88, 101, 94, 94, 94, 
	94, 87, 87, 87, 87, 88, 101, 1, 
	87, 96, 90, 91, 99, 100, 96, 90, 
	91, 99, 100, 87, 101, 110, 110, 110, 
	110, 87, 87, 87, 87, 87, 101, 1, 
	95, 96, 97, 98, 99, 111, 96, 97, 
	98, 99, 111, 95, 101, 102, 102, 102, 
	102, 95, 95, 95, 95, 95, 101, 1, 
	95, 96, 97, 112, 99, 100, 96, 97, 
	112, 99, 100, 95, 101, 102, 102, 102, 
	102, 95, 95, 95, 95, 95, 101, 1, 
	95, 96, 97, 113, 98, 103, 99, 100, 
	96, 97, 113, 98, 103, 99, 100, 95, 
	101, 102, 102, 102, 102, 95, 95, 95, 
	95, 95, 101, 1, 95, 96, 97, 98, 
	99, 114, 100, 96, 97, 98, 99, 114, 
	100, 95, 101, 102, 102, 102, 102, 95, 
	95, 95, 95, 95, 101, 1, 95, 96, 
	97, 98, 99, 115, 96, 97, 98, 99, 
	115, 95, 101, 102, 102, 102, 102, 95, 
	95, 95, 95, 95, 101, 1, 116, 117, 
	118, 119, 120, 121, 117, 118, 119, 120, 
	121, 7, 7, 7, 7, 7, 116, 7, 
	7, 7, 1, 116, 117, 118, 122, 120, 
	121, 117, 118, 122, 120, 121, 7, 7, 
	7, 7, 7, 116, 7, 7, 7, 1, 
	0
]

class << self
	attr_accessor :_parser_trans_targs
	private :_parser_trans_targs, :_parser_trans_targs=
end
self._parser_trans_targs = [
	1, 0, 2, 3, 4, 35, 3, 36, 
	95, 6, 7, 8, 9, 17, 10, 11, 
	12, 13, 14, 15, 16, 81, 19, 20, 
	21, 22, 23, 24, 25, 26, 27, 84, 
	29, 30, 31, 32, 85, 4, 36, 37, 
	38, 39, 43, 45, 51, 60, 63, 40, 
	41, 42, 76, 44, 75, 46, 47, 48, 
	49, 50, 56, 52, 53, 54, 55, 36, 
	57, 58, 59, 36, 61, 62, 36, 64, 
	65, 66, 74, 67, 68, 69, 70, 71, 
	72, 73, 36, 37, 77, 78, 79, 80, 
	88, 90, 80, 82, 80, 91, 89, 80, 
	5, 80, 82, 18, 28, 87, 80, 83, 
	86, 5, 28, 80, 87, 87, 80, 33, 
	92, 93, 94, 34, 96, 38, 39, 43, 
	45, 51, 60
]

class << self
	attr_accessor :_parser_trans_actions
	private :_parser_trans_actions, :_parser_trans_actions=
end
self._parser_trans_actions = [
	0, 0, 0, 3, 5, 5, 0, 7, 
	7, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 21, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 13, 
	0, 0, 0, 15, 17, 0, 0, 0, 
	19, 27, 0, 11, 0, 0, 0, 0, 
	0, 19, 0, 0, 0, 0, 0, 0, 
	19, 0, 0, 0, 0, 0, 15, 17, 
	0, 0, 0, 13, 0, 0, 25, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 21, 23, 0, 0, 0, 29, 
	29, 57, 48, 29, 54, 29, 33, 0, 
	69, 27, 0, 63, 31, 31, 1, 0, 
	0, 19, 0, 23, 45, 0, 51, 31, 
	0, 0, 0, 66, 7, 39, 42, 7, 
	36, 7, 7
]

class << self
	attr_accessor :_parser_eof_actions
	private :_parser_eof_actions, :_parser_eof_actions=
end
self._parser_eof_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 9, 9, 9, 9, 
	9, 9, 9, 9, 9, 9, 9, 9, 
	9, 9, 9, 9, 9, 9, 9, 9, 
	9, 9, 9, 9, 9, 9, 9, 9, 
	9, 9, 9, 9, 9, 9, 9, 9, 
	9, 9, 9, 9, 9, 9, 9, 9, 
	60, 9, 60, 60, 9, 9, 60, 9, 
	60, 60, 60, 60, 60, 60, 60, 9, 
	9
]

class << self
	attr_accessor :parser_start
end
self.parser_start = 1;
class << self
	attr_accessor :parser_first_final
end
self.parser_first_final = 36;
class << self
	attr_accessor :parser_error
end
self.parser_error = 0;

class << self
	attr_accessor :parser_en_main
end
self.parser_en_main = 1;


# line 174 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
      # % (this fixes syntax highlighting)
      parens = quote_value = 0
      p = item = 0
      pe = eof = data.length
      
# line 820 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = parser_start
end

# line 179 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
      # % (this fixes syntax highlighting)
      
# line 830 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.rb"
begin
	_klen, _trans, _keys, _widec, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_widec = data[p].ord
	_keys = _parser_cond_offsets[cs]*2
	_klen = _parser_cond_lengths[cs]
	if _klen > 0
		_lower = _keys
		_upper = _keys + (_klen<<1) - 2
		loop do
			break if _upper < _lower
			_mid = _lower + (((_upper-_lower) >> 1) & ~1)
			if _widec < _parser_cond_keys[_mid]
				_upper = _mid - 2
			elsif _widec > _parser_cond_keys[_mid+1]
				_lower = _mid + 2
			else
				case _parser_cond_spaces[_parser_cond_offsets[cs] + ((_mid - _keys)>>1)]
	when 0 then	_widec = 128+ (data[p].ord - -128)
	_widec += 256 if ( 
# line 56 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
 (quote_value % 2) == 0  )
	when 1 then	_widec = 640+ (data[p].ord - -128)
	_widec += 256 if ( 
# line 57 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
 (quote_value % 2) == 1  )
				end # case
			end
		end # loop
	end
	_keys = _parser_key_offsets[cs]
	_trans = _parser_index_offsets[cs]
	_klen = _parser_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if _widec < _parser_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif _widec > _parser_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _parser_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if _widec < _parser_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif _widec > _parser_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _parser_indicies[_trans]
	cs = _parser_trans_targs[_trans]
	if _parser_trans_actions[_trans] != 0
		_acts = _parser_trans_actions[_trans]
		_nacts = _parser_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _parser_actions[_acts - 1]
when 0 then
# line 12 "/Users/seamusabshere/code/create_table/lib/create_table/common.rl"
		begin
quote_value+=1		end
when 1 then
# line 9 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 start_name = p 		end
when 2 then
# line 10 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 self.name = read(data, start_name, p) 		end
when 3 then
# line 12 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 start_data_type = p 		end
when 5 then
# line 18 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 mark_primary_key = p - 1 		end
when 6 then
# line 19 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin

                             primary_key!
                             end_data_type ||= mark_primary_key
                           		end
when 7 then
# line 24 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 mark_unique = p - 5 		end
when 8 then
# line 25 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin

                             unique!
                             end_data_type ||= mark_unique
                           		end
when 9 then
# line 30 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 mark_autoincrement = p - 1 		end
when 10 then
# line 31 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin

                             autoincrement!
                             end_data_type ||= mark_autoincrement
                           		end
when 11 then
# line 36 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 mark_not_null = p - 4 		end
when 12 then
# line 37 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin

                             mark_not_null ||= nil
                             if mark_not_null
                               self.null = false
                               end_data_type ||= mark_not_null
                             else
                               self.null = true
                               end_data_type ||= p - 4
                             end
                           		end
when 13 then
# line 48 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 mark_default = p - 1 		end
when 14 then
# line 49 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin
 start_default = p 		end
when 15 then
# line 50 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin

                             self.default = read(data, start_default, p).sub(/['"]$/, '').gsub(/(['"])\1/, '\1')
                             end_data_type ||= mark_default
                           		end
# line 1019 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	__acts = _parser_eof_actions[cs]
	__nacts =  _parser_actions[__acts]
	__acts += 1
	while __nacts > 0
		__nacts -= 1
		__acts += 1
		case _parser_actions[__acts - 1]
when 4 then
# line 13 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin

                             end_data_type ||= p
                             self.data_type = read(data, start_data_type, end_data_type)
                           		end
when 15 then
# line 50 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
		begin

                             self.default = read(data, start_default, p).sub(/['"]$/, '').gsub(/(['"])\1/, '\1')
                             end_data_type ||= mark_default
                           		end
# line 1061 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.rb"
		end # eof action switch
	end
	if _trigger_goto
		next
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 181 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl.tmp"
      # % (this fixes syntax highlighting)
      self
    end
  end
end
