%%{
  machine parser;
  ident = [_a-zA-Z][_a-zA-Z0-9]*;
  quote = ["`]?;
  lparens = space* '(' space*;
  rparens = space* ')' space*;
  parens_counter = ( any | '(' @{parens+=1} | ')' @{parens-=1} )*;
  options = any+ & parens_counter;
}%%
