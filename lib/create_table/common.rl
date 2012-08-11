%%{
  machine parser;
  ident = [_a-zA-Z][_a-zA-Z0-9]*;
  # ` is mysql for ident
  quote_ident = ["`]?;
  # " is mysql for value
  quote_value = ['"];
  lparens = space* '(' space*;
  rparens = space* ')' space*;
  parens_counter = ( any | '(' @{parens+=1} | ')' @{parens-=1} )*;
  with_parens = any+ & parens_counter;
  quote_value_counter = ( any | quote_value @{quote_value+=1} )*;
  with_quote_value = (quote_value? any+ quote_value?) & quote_value_counter;
}%%
