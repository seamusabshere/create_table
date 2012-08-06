
# line 1 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
require 'create_table/version'
require 'create_table/column'

# MAKE SURE YOU'RE EDITING THE .RL FILE !!!


# Abridged BNF for SQL99 from http://pivotalrb.rubyforge.org/svn/sql_parser/trunk/resources/sql99.bnf
=begin
<table definition> ::= CREATE [ <table scope> ] TABLE <table name> <table contents source>

<table contents source> ::= <table element list>

<table element list> ::= <left paren> <table element> [ { <comma> <table element> }... ] <right paren>

<table element> ::=
    <column definition>
  | <table constraint definition>
  | <like clause>
  | <self-referencing column specification>
  | <column options>

<column definition> ::=
    <column name>
    { <data type> | <domain name> }
    [ <reference scope check> ]
    [ <default clause> ]
    [ <column constraint definition>... ]
    [ <collate clause> ]

<column name> ::= <identifier>

## Skipped

<table scope> ::= <global or local> TEMPORARY

<global or local> ::= GLOBAL | LOCAL

All that stuff about table name


# line 100 "/Users/seamusabshere/code/create_table/lib/create_table.rl"

=end

class CreateTable
  attr_reader :data

  attr_reader :columns
  attr_accessor :table_name
  
  def initialize(sql)
    @data = sql.unpack('c*')
    @columns = []
    parse!
  end

  private

  def read(s, p)
    data[s, p-s].pack('c*').strip
  end

  def parse!
    
# line 68 "/Users/seamusabshere/code/create_table/lib/create_table.rb"
class << self
	attr_accessor :_chopper_cond_keys
	private :_chopper_cond_keys, :_chopper_cond_keys=
end
self._chopper_cond_keys = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	41, 44, 0, 0, 41, 44, 0, 0, 
	0
]

class << self
	attr_accessor :_chopper_cond_key_spans
	private :_chopper_cond_key_spans, :_chopper_cond_key_spans=
end
self._chopper_cond_key_spans = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 4, 0, 4, 0, 
	
]

class << self
	attr_accessor :_chopper_cond_spaces
	private :_chopper_cond_spaces, :_chopper_cond_spaces=
end
self._chopper_cond_spaces = [
	1, 0, 0, 1, 1, 0, 0, 1, 
	0
]

class << self
	attr_accessor :_chopper_cond_offsets
	private :_chopper_cond_offsets, :_chopper_cond_offsets=
end
self._chopper_cond_offsets = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 4, 4, 8
]

class << self
	attr_accessor :_chopper_trans_keys
	private :_chopper_trans_keys, :_chopper_trans_keys=
end
self._chopper_trans_keys = [
	0, 0, 9, 99, 82, 114, 
	69, 101, 65, 97, 84, 
	116, 69, 101, 9, 32, 
	9, 116, 65, 97, 66, 98, 
	76, 108, 69, 101, 9, 
	32, 9, 122, 9, 122, 
	9, 40, 9, 122, 9, 122, 
	9, 41, -128, 556, 9, 
	122, -128, 556, 0, 0, 
	0
]

class << self
	attr_accessor :_chopper_key_spans
	private :_chopper_key_spans, :_chopper_key_spans=
end
self._chopper_key_spans = [
	0, 91, 33, 33, 33, 33, 33, 24, 
	108, 33, 33, 33, 33, 24, 114, 114, 
	32, 114, 114, 33, 685, 114, 685, 0
]

class << self
	attr_accessor :_chopper_index_offsets
	private :_chopper_index_offsets, :_chopper_index_offsets=
end
self._chopper_index_offsets = [
	0, 0, 92, 126, 160, 194, 228, 262, 
	287, 396, 430, 464, 498, 532, 557, 672, 
	787, 820, 935, 1050, 1084, 1770, 1885, 2571
]

class << self
	attr_accessor :_chopper_indicies
	private :_chopper_indicies, :_chopper_indicies=
end
self._chopper_indicies = [
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
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 10, 1, 11, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 11, 1, 
	12, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	12, 1, 13, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 13, 1, 14, 14, 14, 14, 
	14, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 14, 1, 14, 14, 14, 
	14, 14, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 14, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 15, 15, 15, 
	15, 15, 15, 15, 15, 15, 15, 15, 
	15, 15, 15, 15, 15, 15, 15, 15, 
	15, 15, 15, 15, 15, 15, 15, 1, 
	1, 1, 1, 15, 1, 15, 15, 15, 
	15, 15, 15, 15, 15, 15, 15, 15, 
	15, 15, 15, 15, 15, 15, 15, 15, 
	15, 15, 15, 15, 15, 15, 15, 1, 
	16, 16, 16, 16, 16, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 16, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 1, 1, 1, 1, 1, 1, 1, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 1, 1, 1, 1, 17, 1, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 17, 17, 17, 17, 17, 17, 
	17, 17, 1, 18, 18, 18, 18, 18, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 18, 1, 1, 1, 1, 1, 
	1, 1, 19, 1, 19, 19, 19, 19, 
	19, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 19, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 1, 1, 
	1, 1, 20, 1, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 1, 21, 
	21, 21, 21, 21, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 21, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 22, 22, 
	22, 22, 22, 22, 22, 22, 22, 22, 
	1, 1, 1, 1, 1, 1, 1, 22, 
	22, 22, 22, 22, 22, 22, 22, 22, 
	22, 22, 22, 22, 22, 22, 22, 22, 
	22, 22, 22, 22, 22, 22, 22, 22, 
	22, 1, 1, 1, 1, 22, 1, 22, 
	22, 22, 22, 22, 22, 22, 22, 22, 
	22, 22, 22, 22, 22, 22, 22, 22, 
	22, 22, 22, 22, 22, 22, 22, 22, 
	22, 1, 24, 24, 24, 24, 24, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 24, 23, 23, 23, 23, 23, 23, 
	23, 25, 26, 23, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 28, 1, 27, 27, 
	1, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 27, 27, 27, 27, 
	27, 27, 27, 27, 1, 1, 1, 1, 
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
	1, 1, 1, 1, 1, 29, 1, 1, 
	27, 1, 1, 1, 1, 1, 1, 1, 
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
	1, 1, 1, 1, 1, 30, 1, 1, 
	30, 1, 19, 19, 19, 19, 19, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 19, 1, 1, 1, 1, 1, 1, 
	1, 1, 31, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 1, 1, 1, 1, 
	20, 1, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 20, 20, 20, 20, 
	20, 20, 20, 20, 1, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 24, 24, 
	24, 24, 24, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 24, 23, 23, 
	23, 23, 23, 23, 23, 25, 1, 23, 
	23, 1, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 23, 23, 23, 
	23, 23, 23, 23, 23, 1, 1, 1, 
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
	1, 1, 1, 1, 1, 1, 26, 1, 
	1, 23, 1, 1, 1, 1, 1, 1, 
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
	1, 1, 1, 1, 1, 1, 30, 1, 
	1, 30, 1, 1, 0
]

class << self
	attr_accessor :_chopper_trans_targs
	private :_chopper_trans_targs, :_chopper_trans_targs=
end
self._chopper_trans_targs = [
	1, 0, 2, 3, 4, 5, 6, 7, 
	8, 9, 10, 11, 12, 13, 14, 15, 
	16, 15, 16, 17, 18, 19, 18, 20, 
	22, 20, 20, 20, 20, 20, 21, 23
]

class << self
	attr_accessor :_chopper_trans_actions
	private :_chopper_trans_actions, :_chopper_trans_actions=
end
self._chopper_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	2, 0, 0, 0, 3, 4, 0, 5, 
	5, 6, 7, 0, 8, 9, 10, 0
]

class << self
	attr_accessor :chopper_start
end
self.chopper_start = 1;
class << self
	attr_accessor :chopper_first_final
end
self.chopper_first_final = 23;
class << self
	attr_accessor :chopper_error
end
self.chopper_error = 0;

class << self
	attr_accessor :chopper_en_main
end
self.chopper_en_main = 1;


# line 123 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
    # % (this fixes syntax highlighting)
    
    parentheses = 0
    p = item = 0
    pe = eof = data.length

    
# line 528 "/Users/seamusabshere/code/create_table/lib/create_table.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = chopper_start
end

# line 130 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
    # % (this fixes syntax highlighting)

    
# line 539 "/Users/seamusabshere/code/create_table/lib/create_table.rb"
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
	_conds = _chopper_cond_offsets[cs]
	_slen = _chopper_cond_key_spans[cs]
	_cond = if ( _slen > 0 && 
		     _chopper_cond_keys[_keys] <= _widec &&
		     _widec <= _chopper_cond_keys[_keys + 1]
		   ) then 
			_chopper_cond_spaces[ _conds + _widec - _chopper_cond_keys[_keys] ]
		else
		       0
		end
	case _cond 
	when 1 then
		_widec = (128 + (data[p].ord - -128))
		if ( 
# line 82 "/Users/seamusabshere/code/create_table/lib/create_table.rl"

    r = (parentheses == 0)
    $stderr.puts "outside(#{r.inspect})" if ENV['VERBOSE'] == 'true'
    r
   ) then 
			  _widec += 256
end
	end # _cond switch 
	_keys = cs << 1
	_inds = _chopper_index_offsets[cs]
	_slen = _chopper_key_spans[cs]
	_trans = if (   _slen > 0 && 
			_chopper_trans_keys[_keys] <= _widec && 
			_widec <= _chopper_trans_keys[_keys + 1] 
		    ) then
			_chopper_indicies[ _inds + _widec - _chopper_trans_keys[_keys] ] 
		 else 
			_chopper_indicies[ _inds + _slen ]
		 end
	cs = _chopper_trans_targs[_trans]
	if _chopper_trans_actions[_trans] != 0
	case _chopper_trans_actions[_trans]
	when 1 then
# line 43 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    s = p
  		end
	when 2 then
# line 46 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    self.table_name = read(s, p)
    s = nil
  		end
	when 3 then
# line 50 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "n_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
	when 4 then
# line 54 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "n_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col = Column.new(self, read(s, p))
    columns << col
    s = nil
  		end
	when 5 then
# line 60 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
	when 10 then
# line 64 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col.options = read(s, p)
    s = nil
  		end
	when 8 then
# line 69 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "inc" if ENV['VERBOSE'] == 'true'
    parentheses += 1
  		end
	when 9 then
# line 73 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "dec" if ENV['VERBOSE'] == 'true'
    parentheses -= 1
  		end
	when 6 then
# line 60 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
# line 69 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "inc" if ENV['VERBOSE'] == 'true'
    parentheses += 1
  		end
	when 7 then
# line 60 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  		end
# line 73 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
		begin

    $stderr.puts "dec" if ENV['VERBOSE'] == 'true'
    parentheses -= 1
  		end
# line 684 "/Users/seamusabshere/code/create_table/lib/create_table.rb"
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

# line 133 "/Users/seamusabshere/code/create_table/lib/create_table.rl"
    # % (this fixes syntax highlighting)
  end
end
