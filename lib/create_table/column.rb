
# line 1 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin

# line 64 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"

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
      
# line 32 "/Users/seamusabshere/code/create_table/lib/create_table/column.rb"
class << self
	attr_accessor :_parser_trans_keys
	private :_parser_trans_keys, :_parser_trans_keys=
end
self._parser_trans_keys = [
	0, 0, 9, 122, 65, 122, 
	9, 122, 9, 32, 9, 
	32, 65, 117, 65, 117, 
	65, 117, 65, 117, 65, 117, 
	65, 117, 65, 117, 65, 
	121, 65, 117, 65, 117, 
	65, 117, 65, 117, 65, 117, 
	9, 117, 9, 117, 65, 
	117, 65, 121, 65, 117, 
	65, 117, 65, 117, 65, 117, 
	65, 117, 65, 117, 65, 
	117, 65, 117, 65, 117, 
	65, 117, 65, 117, 65, 117, 
	9, 117, 0
]

class << self
	attr_accessor :_parser_key_spans
	private :_parser_key_spans, :_parser_key_spans=
end
self._parser_key_spans = [
	0, 114, 58, 114, 24, 24, 53, 53, 
	53, 53, 53, 53, 53, 57, 53, 53, 
	53, 53, 53, 109, 109, 53, 57, 53, 
	53, 53, 53, 53, 53, 53, 53, 53, 
	53, 53, 53, 109
]

class << self
	attr_accessor :_parser_index_offsets
	private :_parser_index_offsets, :_parser_index_offsets=
end
self._parser_index_offsets = [
	0, 0, 115, 174, 289, 314, 339, 393, 
	447, 501, 555, 609, 663, 717, 775, 829, 
	883, 937, 991, 1045, 1155, 1265, 1319, 1377, 
	1431, 1485, 1539, 1593, 1647, 1701, 1755, 1809, 
	1863, 1917, 1971, 2025
]

class << self
	attr_accessor :_parser_indicies
	private :_parser_indicies, :_parser_indicies=
end
self._parser_indicies = [
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 0, 
	1, 2, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 1, 1, 1, 1, 3, 2, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 1, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 1, 1, 1, 
	1, 3, 1, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 1, 4, 4, 
	4, 4, 4, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 4, 1, 5, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 6, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 1, 
	1, 1, 1, 1, 1, 1, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 6, 
	1, 1, 1, 1, 6, 5, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 6, 
	6, 6, 6, 6, 6, 6, 6, 6, 
	1, 8, 8, 8, 8, 8, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	8, 7, 9, 9, 9, 9, 9, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 9, 1, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 11, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 14, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 11, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 14, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 12, 10, 
	15, 10, 10, 13, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 12, 10, 
	15, 10, 10, 13, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 16, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 16, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 17, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 17, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 18, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 13, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 18, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 13, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 12, 10, 
	19, 10, 10, 14, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 12, 10, 
	19, 10, 10, 14, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 10, 10, 20, 10, 10, 
	10, 10, 10, 10, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 10, 10, 20, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 21, 10, 12, 10, 
	10, 10, 10, 13, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 21, 10, 12, 10, 
	10, 10, 10, 13, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 22, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 22, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 12, 23, 10, 10, 10, 13, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 12, 23, 10, 10, 10, 13, 
	10, 11, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 24, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 11, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 24, 10, 11, 
	10, 10, 10, 25, 10, 10, 10, 10, 
	10, 10, 10, 10, 21, 10, 12, 10, 
	10, 10, 10, 13, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 11, 
	10, 10, 10, 25, 10, 10, 10, 10, 
	10, 10, 10, 10, 21, 10, 12, 10, 
	10, 10, 10, 13, 10, 26, 26, 26, 
	26, 26, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 26, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 26, 26, 26, 26, 26, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 26, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 27, 10, 10, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 27, 10, 10, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 11, 10, 10, 10, 28, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 13, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 11, 10, 10, 10, 28, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 13, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 12, 10, 
	10, 10, 10, 13, 10, 10, 10, 29, 
	10, 10, 10, 10, 10, 10, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 12, 10, 
	10, 10, 10, 13, 10, 10, 10, 29, 
	10, 11, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 21, 10, 
	12, 10, 10, 10, 30, 13, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 11, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 21, 10, 
	12, 10, 10, 10, 30, 13, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 31, 12, 10, 
	10, 10, 10, 13, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 31, 12, 10, 
	10, 10, 10, 13, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 32, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 33, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 32, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	34, 10, 12, 10, 10, 10, 10, 13, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	34, 10, 12, 10, 10, 10, 10, 13, 
	10, 11, 10, 35, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 13, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 11, 10, 35, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 13, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 12, 10, 
	36, 10, 10, 13, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 12, 10, 
	36, 10, 10, 13, 10, 11, 10, 10, 
	10, 37, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 11, 10, 10, 
	10, 37, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	10, 13, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 38, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 38, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 11, 10, 10, 10, 39, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 13, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 11, 10, 10, 10, 39, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	12, 10, 10, 10, 10, 13, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 40, 10, 12, 10, 
	10, 10, 10, 13, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 11, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 40, 10, 12, 10, 
	10, 10, 10, 13, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	41, 13, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 11, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 12, 10, 10, 10, 
	41, 13, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 32, 10, 10, 10, 10, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 11, 10, 10, 10, 10, 
	10, 10, 10, 32, 10, 10, 10, 10, 
	10, 10, 12, 10, 10, 10, 10, 13, 
	10, 8, 8, 8, 8, 8, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	8, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 42, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	43, 7, 7, 7, 7, 44, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 42, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	43, 7, 7, 7, 7, 44, 7, 0
]

class << self
	attr_accessor :_parser_trans_targs
	private :_parser_trans_targs, :_parser_trans_targs=
end
self._parser_trans_targs = [
	1, 0, 2, 3, 4, 5, 3, 6, 
	35, 4, 6, 7, 8, 14, 23, 9, 
	10, 11, 12, 13, 19, 15, 16, 17, 
	18, 6, 20, 21, 22, 6, 24, 25, 
	26, 34, 27, 28, 29, 30, 31, 32, 
	33, 6, 7, 8, 14
]

class << self
	attr_accessor :_parser_trans_actions
	private :_parser_trans_actions, :_parser_trans_actions=
end
self._parser_trans_actions = [
	0, 0, 0, 1, 2, 2, 0, 3, 
	3, 0, 0, 5, 6, 0, 0, 0, 
	0, 0, 5, 0, 0, 0, 0, 0, 
	7, 8, 0, 0, 0, 9, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 10, 11, 12, 3
]

class << self
	attr_accessor :_parser_eof_actions
	private :_parser_eof_actions, :_parser_eof_actions=
end
self._parser_eof_actions = [
	0, 0, 0, 0, 0, 0, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4
]

class << self
	attr_accessor :parser_start
end
self.parser_start = 1;
class << self
	attr_accessor :parser_first_final
end
self.parser_first_final = 6;
class << self
	attr_accessor :parser_error
end
self.parser_error = 0;

class << self
	attr_accessor :parser_en_main
end
self.parser_en_main = 1;


# line 87 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
      # % (this fixes syntax highlighting)
      parens = 0
      p = item = 0
      pe = eof = data.length
      
# line 415 "/Users/seamusabshere/code/create_table/lib/create_table/column.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = parser_start
end

# line 92 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
      # % (this fixes syntax highlighting)
      
# line 425 "/Users/seamusabshere/code/create_table/lib/create_table/column.rb"
begin
	testEof = false
	_slen, _trans, _keys, _inds, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
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
	_keys = cs << 1
	_inds = _parser_index_offsets[cs]
	_slen = _parser_key_spans[cs]
	_trans = if (   _slen > 0 && 
			_parser_trans_keys[_keys] <= data[p].ord && 
			data[p].ord <= _parser_trans_keys[_keys + 1] 
		    ) then
			_parser_indicies[ _inds + data[p].ord - _parser_trans_keys[_keys] ] 
		 else 
			_parser_indicies[ _inds + _slen ]
		 end
	cs = _parser_trans_targs[_trans]
	if _parser_trans_actions[_trans] != 0
	case _parser_trans_actions[_trans]
	when 1 then
# line 9 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    start_name = p
  		end
	when 2 then
# line 12 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    self.name = read(data, start_name, p)
    start_name = nil
  		end
	when 3 then
# line 17 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "StartDataType(#{p})" if ENV['VERBOSE'] == 'true'
    start_data_type = p
  		end
	when 6 then
# line 27 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "StartPrimaryKey(#{p})" if ENV['VERBOSE'] == 'true'
    start_primary_key = p
  		end
	when 9 then
# line 31 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "PrimaryKey(#{p})" if ENV['VERBOSE'] == 'true'
    primary_key!
    end_data_type ||= start_primary_key
  		end
	when 7 then
# line 37 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "StartUnique(p=#{p})" if ENV['VERBOSE'] == 'true'
    start_unique = p - 4
  		end
	when 8 then
# line 41 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "Unique(p=#{p})" if ENV['VERBOSE'] == 'true'
    unique!
    end_data_type ||= start_unique
  		end
	when 5 then
# line 47 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "StartAutoincrement(#{p})" if ENV['VERBOSE'] == 'true'
    start_autoincrement = p
  		end
	when 10 then
# line 51 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "Autoincrement(#{p})" if ENV['VERBOSE'] == 'true'
    autoincrement!
    end_data_type ||= start_autoincrement
  		end
	when 12 then
# line 17 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "StartDataType(#{p})" if ENV['VERBOSE'] == 'true'
    start_data_type = p
  		end
# line 27 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "StartPrimaryKey(#{p})" if ENV['VERBOSE'] == 'true'
    start_primary_key = p
  		end
	when 11 then
# line 17 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "StartDataType(#{p})" if ENV['VERBOSE'] == 'true'
    start_data_type = p
  		end
# line 47 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    $stderr.puts "StartAutoincrement(#{p})" if ENV['VERBOSE'] == 'true'
    start_autoincrement = p
  		end
# line 552 "/Users/seamusabshere/code/create_table/lib/create_table/column.rb"
	end
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
	  case _parser_eof_actions[cs]
	when 4 then
# line 21 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
		begin

    end_data_type ||= p
    $stderr.puts "EndDataType(#{start_data_type}, #{end_data_type}, p=#{p}) - #{read(data, start_data_type, end_data_type).inspect}" if ENV['VERBOSE'] == 'true'
    self.data_type = read(data, start_data_type, end_data_type)
  		end
# line 578 "/Users/seamusabshere/code/create_table/lib/create_table/column.rb"
	  end
	end

	end
	if _goto_level <= _out
		break
	end
end
	end

# line 94 "/Users/seamusabshere/code/create_table/lib/create_table/column.rl"
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
