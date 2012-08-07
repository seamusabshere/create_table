
# line 1 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
require 'create_table/version'
require 'create_table/column'

# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin

# line 53 "/Users/seamusabshere/code/create_table/lib/create_table.rl"

=end

class CreateTable
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
    parts << %{TABLE #{table_name} (}
    parts << columns.map(&:to_sql).join(', ')
    parts << ')'
    parts.join ' '
  end

  private

  def read(s, p)
    data[s, p-s].pack('c*').strip
  end

  def parse!
    
# line 54 "/Users/seamusabshere/code/create_table/lib/create_table.rb"
class << self
	attr_accessor :_create_table_parser_cond_keys
	private :_create_table_parser_cond_keys, :_create_table_parser_cond_keys=
end
self._create_table_parser_cond_keys = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 41, 44, 41, 44, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0
]

class << self
	attr_accessor :_create_table_parser_cond_key_spans
	private :_create_table_parser_cond_key_spans, :_create_table_parser_cond_key_spans=
end
self._create_table_parser_cond_key_spans = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 4, 4, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 
]

class << self
	attr_accessor :_create_table_parser_cond_spaces
	private :_create_table_parser_cond_spaces, :_create_table_parser_cond_spaces=
end
self._create_table_parser_cond_spaces = [
	1, 0, 0, 1, 1, 0, 0, 1, 
	0
]

class << self
	attr_accessor :_create_table_parser_cond_offsets
	private :_create_table_parser_cond_offsets, :_create_table_parser_cond_offsets=
end
self._create_table_parser_cond_offsets = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 4, 8, 
	8, 8, 8, 8, 8, 8, 8, 8, 
	8, 8, 8, 8, 8
]

class << self
	attr_accessor :_create_table_parser_trans_keys
	private :_create_table_parser_trans_keys, :_create_table_parser_trans_keys=
end
self._create_table_parser_trans_keys = [
	0, 0, 9, 99, 82, 114, 
	69, 101, 65, 97, 84, 
	116, 69, 101, 9, 32, 
	9, 116, 65, 101, 66, 98, 
	76, 108, 69, 101, 9, 
	32, 9, 122, 65, 122, 
	9, 122, 9, 40, 9, 122, 
	65, 122, 9, 122, -128, 
	556, -128, 556, 9, 122, 
	9, 32, 9, 32, 77, 109, 
	80, 112, 79, 111, 82, 
	114, 65, 97, 82, 114, 
	89, 121, 9, 32, 9, 116, 
	65, 97, 0, 0, 0
]

class << self
	attr_accessor :_create_table_parser_key_spans
	private :_create_table_parser_key_spans, :_create_table_parser_key_spans=
end
self._create_table_parser_key_spans = [
	0, 91, 33, 33, 33, 33, 33, 24, 
	108, 37, 33, 33, 33, 24, 114, 58, 
	114, 32, 114, 58, 114, 685, 685, 114, 
	24, 24, 33, 33, 33, 33, 33, 33, 
	33, 24, 108, 33, 0
]

class << self
	attr_accessor :_create_table_parser_index_offsets
	private :_create_table_parser_index_offsets, :_create_table_parser_index_offsets=
end
self._create_table_parser_index_offsets = [
	0, 0, 92, 126, 160, 194, 228, 262, 
	287, 396, 434, 468, 502, 536, 561, 676, 
	735, 850, 883, 998, 1057, 1172, 1858, 2544, 
	2659, 2684, 2709, 2743, 2777, 2811, 2845, 2879, 
	2913, 2947, 2972, 3081, 3115
]

class << self
	attr_accessor :_create_table_parser_indicies
	private :_create_table_parser_indicies, :_create_table_parser_indicies=
end
self._create_table_parser_indicies = [
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 0, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 2, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 2, 1, 3, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 3, 1, 4, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 4, 1, 
	5, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	5, 1, 6, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 6, 1, 7, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 7, 1, 8, 8, 
	8, 8, 8, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 8, 1, 8, 
	8, 8, 8, 8, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 8, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 9, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 9, 1, 10, 1, 1, 1, 
	11, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 10, 1, 1, 1, 
	11, 1, 12, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 12, 1, 13, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 13, 1, 14, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 14, 1, 
	15, 15, 15, 15, 15, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 15, 
	1, 15, 15, 15, 15, 15, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	15, 1, 16, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 1, 1, 1, 1, 17, 
	16, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 1, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 1, 1, 
	1, 1, 17, 1, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 1, 18, 
	18, 18, 18, 18, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 18, 1, 
	19, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	1, 1, 1, 1, 1, 1, 1, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 1, 1, 1, 1, 20, 19, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 1, 21, 21, 21, 21, 21, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 21, 1, 1, 1, 1, 1, 1, 
	1, 22, 1, 22, 22, 22, 22, 22, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 22, 1, 23, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 1, 1, 1, 
	1, 24, 23, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 1, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	1, 1, 1, 1, 24, 1, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	1, 25, 25, 25, 25, 25, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	25, 1, 26, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 1, 1, 1, 1, 1, 1, 
	1, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 1, 1, 1, 1, 27, 
	26, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 1, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 29, 29, 29, 
	29, 29, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 29, 28, 28, 28, 
	28, 28, 28, 28, 30, 1, 28, 28, 
	1, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 28, 28, 28, 28, 
	28, 28, 28, 28, 1, 1, 1, 1, 
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
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 31, 1, 1, 
	28, 1, 1, 1, 1, 1, 1, 1, 
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
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 32, 1, 1, 
	32, 1, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 34, 1, 33, 33, 1, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 33, 33, 33, 33, 33, 33, 
	33, 33, 1, 1, 1, 1, 1, 1, 
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
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 35, 1, 1, 33, 1, 
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
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 36, 1, 1, 36, 1, 
	22, 22, 22, 22, 22, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 22, 
	1, 23, 1, 1, 1, 1, 1, 1, 
	37, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 1, 1, 1, 1, 24, 23, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 24, 24, 24, 24, 24, 24, 
	24, 24, 1, 38, 38, 38, 38, 38, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 38, 1, 21, 21, 21, 21, 
	21, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 21, 1, 39, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 39, 1, 40, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 40, 
	1, 41, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 41, 1, 42, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 42, 1, 43, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 43, 1, 44, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 44, 
	1, 45, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 45, 1, 46, 46, 46, 46, 46, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 46, 1, 46, 46, 46, 46, 
	46, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 46, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 47, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 47, 
	1, 10, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 10, 1, 1, 0
]

class << self
	attr_accessor :_create_table_parser_trans_targs
	private :_create_table_parser_trans_targs, :_create_table_parser_trans_targs=
end
self._create_table_parser_trans_targs = [
	1, 0, 2, 3, 4, 5, 6, 7, 
	8, 9, 10, 26, 11, 12, 13, 14, 
	15, 16, 17, 25, 16, 17, 18, 19, 
	20, 21, 24, 20, 22, 21, 22, 22, 
	23, 22, 22, 22, 23, 36, 21, 27, 
	28, 29, 30, 31, 32, 33, 34, 35
]

class << self
	attr_accessor :_create_table_parser_trans_actions
	private :_create_table_parser_trans_actions, :_create_table_parser_trans_actions=
end
self._create_table_parser_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 2, 2, 0, 0, 0, 0, 
	3, 4, 4, 0, 5, 5, 6, 7, 
	8, 0, 9, 10, 11, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 12, 0
]

class << self
	attr_accessor :create_table_parser_start
end
self.create_table_parser_start = 1;
class << self
	attr_accessor :create_table_parser_first_final
end
self.create_table_parser_first_final = 36;
class << self
	attr_accessor :create_table_parser_error
end
self.create_table_parser_error = 0;

class << self
	attr_accessor :create_table_parser_en_main
end
self.create_table_parser_en_main = 1;


# line 95 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
    # % (this fixes syntax highlighting)
    
    parentheses = 0
    p = item = 0
    pe = eof = data.length

    
# line 600 "/Users/seamusabshere/code/create_table/lib/create_table.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = create_table_parser_start
end

# line 102 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
    # % (this fixes syntax highlighting)

    
# line 611 "/Users/seamusabshere/code/create_table/lib/create_table.rb"
begin
	testEof = false
	_slen, _trans, _keys, _inds, _cond, _conds, _widec, _acts, _nacts = nil
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
	_widec = data[p].ord
	_keys = cs << 1
	_conds = _create_table_parser_cond_offsets[cs]
	_slen = _create_table_parser_cond_key_spans[cs]
	_cond = if ( _slen > 0 && 
		     _create_table_parser_cond_keys[_keys] <= _widec &&
		     _widec <= _create_table_parser_cond_keys[_keys + 1]
		   ) then 
			_create_table_parser_cond_spaces[ _conds + _widec - _create_table_parser_cond_keys[_keys] ]
		else
		       0
		end
	case _cond 
	when 1 then
		_widec = (128 + (data[p].ord - -128))
		if ( 
# line 37 "/Users/seamusabshere/code/create_table/lib/create_table.rl"

    r = (parentheses == 0)
    $stderr.puts "outside(#{r.inspect})" if ENV['VERBOSE'] == 'true'
    r
   ) then 
			  _widec += 256
end
	end # _cond switch 
	_keys = cs << 1
	_inds = _create_table_parser_index_offsets[cs]
	_slen = _create_table_parser_key_spans[cs]
	_trans = if (   _slen > 0 && 
			_create_table_parser_trans_keys[_keys] <= _widec && 
			_widec <= _create_table_parser_trans_keys[_keys + 1] 
		    ) then
			_create_table_parser_indicies[ _inds + _widec - _create_table_parser_trans_keys[_keys] ] 
		 else 
			_create_table_parser_indicies[ _inds + _slen ]
		 end
	cs = _create_table_parser_trans_targs[_trans]
	if _create_table_parser_trans_actions[_trans] != 0
	case _create_table_parser_trans_actions[_trans]
	when 1 then
# line 10 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    s = p
  		end
	when 2 then
# line 13 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    self.table_name = read(s, p)
    s = nil
  		end
	when 3 then
# line 17 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "n_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
	when 4 then
# line 21 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "n_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col = add_column read(s, p)
    s = nil
  		end
	when 5 then
# line 26 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
	when 11 then
# line 30 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col.options = read(s, p)
    s = nil
  		end
	when 9 then
# line 45 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin
parentheses+=1		end
	when 10 then
# line 45 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin
parentheses-=1		end
	when 12 then
# line 46 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin
@temporary=true		end
	when 8 then
# line 26 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
# line 30 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col.options = read(s, p)
    s = nil
  		end
	when 6 then
# line 26 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
# line 45 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin
parentheses+=1		end
	when 7 then
# line 26 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
# line 45 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin
parentheses-=1		end
# line 761 "/Users/seamusabshere/code/create_table/lib/create_table.rb"
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
	end
	if _goto_level <= _out
		break
	end
end
	end

# line 105 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
    # % (this fixes syntax highlighting)
  end
end
