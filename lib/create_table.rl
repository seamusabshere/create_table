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

%%{
  machine chopper;

  action table_name_s {
    s = p
  }
  action table_name_e {
    self.table_name = read(s, p)
    s = nil
  }
  action column_name_s {
    $stderr.puts "n_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  }
  action column_name_e {
    $stderr.puts "n_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col = Column.new(self, read(s, p))
    columns << col
    s = nil
  }
  action column_options_s {
    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  }
  action column_options_e {
    $stderr.puts "o_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col.options = read(s, p)
    s = nil
  }
  action inc {
    $stderr.puts "inc" if ENV['VERBOSE'] == 'true'
    parentheses += 1
  }
  action dec {
    $stderr.puts "dec" if ENV['VERBOSE'] == 'true'
    parentheses -= 1
  }
  action inside {
    r = parentheses > 0
    $stderr.puts "inside(#{r.inspect})" if ENV['VERBOSE'] == 'true'
    r
  }
  action outside {
    r = (parentheses == 0)
    $stderr.puts "outside(#{r.inspect})" if ENV['VERBOSE'] == 'true'
    r
  }

  ident = [_a-zA-Z][_a-zA-Z0-9]*;
  q = ["`]?;
  
  # http://www.complang.org/pipermail/ragel-users/2010-April/002404.html
  counter = ( any | '(' @inc | ')' @dec )*;

  create_table      = 'create'i space+ 'table'i;
  table_name        = q ident >table_name_s %table_name_e q;
  column_name       = q ident >column_name_s %column_name_e q;
  column_options    = (any+ & counter) >column_options_s %column_options_e :> ([,)] when outside);
  column_definition = space* column_name space+ column_options;

  main := space* create_table space+ table_name space+ '(' column_definition+ ')';
}%%
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
