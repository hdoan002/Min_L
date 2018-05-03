/* Henry Doan
 * CS 152 Project Phase 1
 */

%{
  int currLine = 1, currPos = 1;
%}

alpha           [a-zA-Z]
digits          [0-9]
tab             [\t]
newline         [\n]
whitespace      [ ]
underscore      [_]
hash            ##.*

underFirst      [_][a-zA-Z0-9_]*[a-zA-Z0-9]*
underLast       [a-zA-Z][a-zA-Z0-9_]*[_]
digitFirst      [0-9][a-zA-Z0-9_]*[a-zA-Z0-9]*
ident           [a-zA-Z]([a-zA-Z0-9_]*[a-zA-Z0-9])*

%%
"function"      { return FUNCTION; currPos += yyleng; }
"beginparams"   { return BEGIN_PARAMS; currPos += yyleng; }
"endparams"     { return END_PARAMS; currPos += yyleng; }
"beginlocals"   { return BEGIN_LOCALS; currPos += yyleng; }
"endlocals"     { return END_LOCALS; currPos += yyleng; }
"beginbody"     { return BEGIN_BODY; currPos += yyleng; }
"endbody"       { return END_BODY; currPos += yyleng; }
"integer"       { return INTEGER; currPos += yyleng; }
"array"         { printf("ARRAY\n"); currPos += yyleng; }
"of"            { printf("OF\n"); currPos += yyleng; }
"if"            { printf("IF\n"); currPos += yyleng; }
"then"          { printf("THEN\n"); currPos += yyleng; }
"endif"         { printf("ENDIF\n"); currPos += yyleng; }
"else"          { printf("ELSE\n"); currPos += yyleng; }
"while"         { printf("WHILE\n"); currPos += yyleng; }
"do"            { printf("DO\n"); currPos += yyleng; }
"beginloop"     { printf("BEGINLOOP\n"); currPos += yyleng; }
"endloop"       { printf("ENDLOOP\n"); currPos += yyleng; }
"continue"      { printf("CONTINUE\n"); currPos += yyleng; }
"read"          { printf("READ\n"); currPos += yyleng; }
"write"         { printf("WRITE\n"); currPos += yyleng; }
"and"           { printf("AND\n"); currPos += yyleng; }
"or"            { printf("OR\n"); currPos += yyleng; }
"not"           { printf("NOT\n"); currPos += yyleng; }
"true"          { printf("TRUE\n"); currPos += yyleng; }
"false"         { printf("FALSE\n"); currPos += yyleng; }
"return"        { printf("RETURN\n"); currPos += yyleng; }
"-"             { printf("SUB\n"); currPos += yyleng; }
"+"             { printf("ADD\n"); currPos += yyleng; }
"*"             { printf("MULT\n"); currPos += yyleng; }
"/"             { printf("DIV\n"); currPos += yyleng; }
"%"             { printf("MOD\n"); currPos += yyleng; }
"=="            { printf("EQ\n"); currPos += yyleng; }
"<>"            { printf("NEQ\n"); currPos += yyleng; }
"<"             { printf("LT\n"); currPos += yyleng; }
">"             { printf("GT\n"); currPos += yyleng; }
"<="            { printf("LTE\n"); currPos += yyleng; }
">="            { printf("GTE\n");  currPos += yyleng; }
";"             { printf("SEMICOLON\n"); currPos += yyleng; }
":"             { printf("COLON\n"); currPos += yyleng; }
","             { printf("COMMA\n"); currPos += yyleng; }
"("             { printf("L_PAREN\n"); currPos += yyleng; }
")"             { printf("R_PAREN\n"); currPos += yyleng; }
"["             { printf("L_SQUARE_BRACKET\n"); currPos += yyleng; }
"]"             { printf("R_SQUARE_BRACKET\n"); currPos += yyleng; }
":="            { printf("ASSIGN\n"); currPos += yyleng; }

{ident}         { printf("IDENT %s\n", yytext); currPos += yyleng; }
{digits}+       { printf("NUMBER %s\n", yytext); currPos += yyleng; }
{hash}          { currPos += yyleng; }
{tab}+          { currPos += yyleng; }
{newline}       { currLine++; currPos = 1; }
{whitespace}+   { currPos += yyleng; }




{underLast}     { printf("Error at line %d, column %d: incorrect identifer (Underscore last) \"%s\"\n", currLine, currPos, yytext); exit(0); }
{underFirst}    { printf("Error at line %d, column %d: incorrect identifer (Underscore first) \"%s\"\n", currLine, currPos, yytext); exit(0); }
{digitFirst}    { printf("Error at line %d, column %d: incorrect identifer (Digit first) \"%s\"\n", currLine, currPos, yytext); exit(0); }
.               { printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0); }


%%
