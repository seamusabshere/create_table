
# MAKE SURE YOU'RE EDITING THE .RL FILE !!!

=begin


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
      
class << self
	attr_accessor :_parser_actions
	private :_parser_actions, :_parser_actions=
end
self._parser_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3
]

class << self
	attr_accessor :_parser_key_offsets
	private :_parser_key_offsets, :_parser_key_offsets=
end
self._parser_key_offsets = [
	0, 0, 10, 15, 27, 31, 40, 45, 
	55, 57, 67
]

class << self
	attr_accessor :_parser_trans_keys
	private :_parser_trans_keys, :_parser_trans_keys=
end
self._parser_trans_keys = [
	32, 34, 40, 96, 9, 13, 65, 90, 
	95, 122, 95, 65, 90, 97, 122, 32, 
	34, 40, 96, 9, 13, 48, 57, 65, 
	90, 95, 122, 32, 40, 9, 13, 32, 
	34, 96, 9, 13, 65, 90, 95, 122, 
	95, 65, 90, 97, 122, 34, 41, 44, 
	96, 48, 57, 65, 90, 95, 122, 41, 
	44, 32, 34, 41, 96, 9, 13, 65, 
	90, 95, 122, 32, 9, 13, 0
]

class << self
	attr_accessor :_parser_single_lengths
	private :_parser_single_lengths, :_parser_single_lengths=
end
self._parser_single_lengths = [
	0, 4, 1, 4, 2, 3, 1, 4, 
	2, 4, 1
]

class << self
	attr_accessor :_parser_range_lengths
	private :_parser_range_lengths, :_parser_range_lengths=
end
self._parser_range_lengths = [
	0, 3, 2, 4, 1, 3, 2, 3, 
	0, 3, 1
]

class << self
	attr_accessor :_parser_index_offsets
	private :_parser_index_offsets, :_parser_index_offsets=
end
self._parser_index_offsets = [
	0, 0, 8, 12, 21, 25, 32, 36, 
	44, 47, 55
]

class << self
	attr_accessor :_parser_indicies
	private :_parser_indicies, :_parser_indicies=
end
self._parser_indicies = [
	0, 2, 3, 2, 0, 4, 4, 1, 
	4, 4, 4, 1, 5, 5, 6, 5, 
	5, 7, 7, 7, 1, 8, 3, 8, 
	1, 3, 9, 9, 3, 10, 10, 1, 
	10, 10, 10, 1, 11, 12, 12, 11, 
	13, 13, 13, 1, 14, 14, 1, 14, 
	9, 15, 9, 14, 10, 10, 1, 15, 
	15, 1, 0
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
	0, 0, 0, 0, 1, 3, 3, 0, 
	0, 0, 5, 7, 7, 0, 0, 0
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


      # % (this fixes syntax highlighting)
      parens = 0
      p = item = 0
      pe = eof = data.length
      
begin
	p ||= 0
	pe ||= data.length
	cs = parser_start
end

      # % (this fixes syntax highlighting)
      
begin
	_klen, _trans, _keys, _acts, _nacts = nil
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

	        if data[p].ord < _parser_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _parser_trans_keys[_mid]
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
	        if data[p].ord < _parser_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _parser_trans_keys[_mid+1]
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
		begin
 start_name = p                                    		end
when 1 then
		begin
 self.name = read(data, start_name, p)             		end
when 2 then
		begin
 start_column_name = p                             		end
when 3 then
		begin
 column_names << read(data, start_column_name, p)  		end
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
	end
	if _goto_level <= _out
		break
	end
	end
	end

      # % (this fixes syntax highlighting)
      self
    end

    def column_names=(column_names)
      @column_names = [column_names].compact.flatten
    end

    def to_sql(format, options)
      return if primary_key
      return if unique and name.nil?
      parts = []
      parts << 'CREATE'
      parts << 'UNIQUE' if (unique and name)
      parts << 'INDEX'
      parts += [ quoted_name(options), 'ON', parent.quoted_table_name(options), '(', quoted_column_names(options), ')' ]
      parts.join ' '
    end

    def primary_key
      if pk = parent.primary_key
        pk.column_names == column_names
      end
    end

    def quoted_name(options)
      if name
        CreateTable.quote_ident name, options
      elsif unique
        "uidx_#{parent.table_name}_on_#{name}"
      else
        "idx_#{parent.table_name}_on_#{name}"
      end
    end

    def quoted_column_names(options)
      column_names.map do |column_name|
        CreateTable.quote_ident column_name, options
      end.join(', ')
    end
  end
end
