
# line 1 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"
# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin

# line 30 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"

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
      
# line 33 "/Users/seamusabshere/code/create_table/lib/create_table/index.rb"
class << self
	attr_accessor :_parser_trans_keys
	private :_parser_trans_keys, :_parser_trans_keys=
end
self._parser_trans_keys = [
	0, 0, 9, 122, 65, 122, 
	9, 122, 9, 40, 9, 
	122, 65, 122, 34, 122, 
	41, 44, 9, 122, 9, 32, 
	0
]

class << self
	attr_accessor :_parser_key_spans
	private :_parser_key_spans, :_parser_key_spans=
end
self._parser_key_spans = [
	0, 114, 58, 114, 32, 114, 58, 89, 
	4, 114, 24
]

class << self
	attr_accessor :_parser_index_offsets
	private :_parser_index_offsets, :_parser_index_offsets=
end
self._parser_index_offsets = [
	0, 0, 115, 174, 289, 322, 437, 496, 
	586, 591, 706
]

class << self
	attr_accessor :_parser_indicies
	private :_parser_indicies, :_parser_indicies=
end
self._parser_indicies = [
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 0, 
	1, 2, 1, 1, 1, 1, 1, 3, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 1, 1, 1, 1, 4, 2, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 1, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 1, 1, 1, 
	1, 4, 1, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 4, 4, 4, 
	4, 4, 4, 4, 4, 1, 5, 5, 
	5, 5, 5, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 5, 1, 5, 
	1, 1, 1, 1, 1, 6, 1, 1, 
	1, 1, 1, 1, 1, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 1, 
	1, 1, 1, 1, 1, 1, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	1, 1, 1, 1, 7, 5, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	1, 8, 8, 8, 8, 8, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	8, 1, 1, 1, 1, 1, 1, 1, 
	3, 1, 3, 3, 3, 3, 3, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 3, 1, 9, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 1, 1, 1, 1, 
	10, 9, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 1, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 1, 
	1, 1, 1, 10, 1, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 1, 
	11, 1, 1, 1, 1, 1, 1, 12, 
	1, 1, 12, 1, 1, 1, 13, 13, 
	13, 13, 13, 13, 13, 13, 13, 13, 
	1, 1, 1, 1, 1, 1, 1, 13, 
	13, 13, 13, 13, 13, 13, 13, 13, 
	13, 13, 13, 13, 13, 13, 13, 13, 
	13, 13, 13, 13, 13, 13, 13, 13, 
	13, 1, 1, 1, 1, 13, 11, 13, 
	13, 13, 13, 13, 13, 13, 13, 13, 
	13, 13, 13, 13, 13, 13, 13, 13, 
	13, 13, 13, 13, 13, 13, 13, 13, 
	13, 1, 14, 1, 1, 14, 1, 14, 
	14, 14, 14, 14, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 14, 1, 
	9, 1, 1, 1, 1, 1, 1, 15, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 1, 1, 1, 1, 10, 9, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 10, 10, 10, 10, 10, 10, 10, 
	10, 1, 15, 15, 15, 15, 15, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 15, 1, 0
]

class << self
	attr_accessor :_parser_trans_targs
	private :_parser_trans_targs, :_parser_trans_targs=
end
self._parser_trans_targs = [
	1, 0, 2, 5, 3, 4, 5, 3, 
	4, 6, 7, 8, 9, 7, 9, 10
]

class << self
	attr_accessor :_parser_trans_actions
	private :_parser_trans_actions, :_parser_trans_actions=
end
self._parser_trans_actions = [
	0, 0, 0, 0, 1, 2, 2, 0, 
	0, 0, 3, 4, 4, 0, 0, 0
]

class << self
	attr_accessor :parser_start
end
self.parser_start = 1;
class << self
	attr_accessor :parser_first_final
end
self.parser_first_final = 10;
class << self
	attr_accessor :parser_error
end
self.parser_error = 0;

class << self
	attr_accessor :parser_en_main
end
self.parser_en_main = 1;


# line 54 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"
      # % (this fixes syntax highlighting)
      parens = 0
      p = item = 0
      pe = eof = data.length
      
# line 206 "/Users/seamusabshere/code/create_table/lib/create_table/index.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = parser_start
end

# line 59 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"
      # % (this fixes syntax highlighting)
      
# line 216 "/Users/seamusabshere/code/create_table/lib/create_table/index.rb"
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
# line 9 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"
		begin

    start_name = p
  		end
	when 2 then
# line 12 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"
		begin

    self.name = read(data, start_name, p)
    start_name = nil
  		end
	when 3 then
# line 16 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"
		begin

    $stderr.puts "StartColumnName(#{p})" if ENV['VERBOSE'] == 'true'
    start_column_name = p
  		end
	when 4 then
# line 20 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"
		begin

    $stderr.puts "EndColumnName(#{start_column_name}, #{p}) - #{read(data, start_column_name, p).inspect}" if ENV['VERBOSE'] == 'true'
    column_names << read(data, start_column_name, p)
    start_column_name = nil
  		end
# line 280 "/Users/seamusabshere/code/create_table/lib/create_table/index.rb"
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

# line 61 "/Users/seamusabshere/code/create_table/lib/create_table/index.rl"
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
