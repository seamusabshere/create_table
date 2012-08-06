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

  action StartTableName {
    s = p
  }
  action EndTableName {
    self.table_name = read(s, p)
    s = nil
  }
  action StartColumnName {
    $stderr.puts "n_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  }
  action EndColumnName {
    $stderr.puts "n_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col = Column.new(self, read(s, p))
    columns << col
    s = nil
  }
  action StartColumnOptions {
    $stderr.puts "o_s(#{p})" if ENV['VERBOSE'] == 'true'
    s = p
  }
  action EndColumnOptions {
    $stderr.puts "o_e(#{s}, #{p}) - #{read(s, p).inspect}" if ENV['VERBOSE'] == 'true'
    col.options = read(s, p)
    s = nil
  }

  # conditions
  action NotEnclosedInParentheses {
    r = (parentheses == 0)
    $stderr.puts "outside(#{r.inspect})" if ENV['VERBOSE'] == 'true'
    r
  }

  ident               = [_a-zA-Z][_a-zA-Z0-9]*;
  quote_ident         = ["`];
  parentheses_counter = ( any | '(' @{parentheses+=1} | ')' @{parentheses-=1} )*;
  create_table        = 'create'i space+ ('temporary'i space+ @{@temporary_query=true})? 'table'i;
  table_name          = quote_ident? ident >StartTableName %EndTableName quote_ident?;
  column_name         = quote_ident? ident >StartColumnName %EndColumnName quote_ident?;
  column_options      = any+ & parentheses_counter >StartColumnOptions %EndColumnOptions :> [,)] when NotEnclosedInParentheses;
  column_definition   = space* column_name space+ column_options;

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

  def temporary?
    @temporary_query == true
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
