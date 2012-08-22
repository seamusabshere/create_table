%%{
  machine parser;
  ident               = [_a-zA-Z][_a-zA-Z0-9]*;
  quote_ident         = ["`]?;
  quote_value         = ['"];
  lparens             = space* '(' space*;
  rparens             = space* ')' space*;
  parens_counter      = ( any | '(' @{parens+=1} | ')' @{parens-=1} )*;
  with_parens         = any+ & parens_counter;
  not_quote_or_escape = [^'"\\];
  escaped_something   = /\\./;
  quoted_quote        = "''";
}%%
