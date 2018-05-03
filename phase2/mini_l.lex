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
"function"      { currPos += yyleng; return FUNCTION; }
"beginparams"   { currPos += yyleng; return BEGIN_PARAMS; }
"endparams"     { currPos += yyleng; return END_PARAMS; }
"beginlocals"   { currPos += yyleng; return BEGIN_LOCALS; }
"endlocals"     { currPos += yyleng; return END_LOCALS; }
"beginbody"     { currPos += yyleng; return BEGIN_BODY; }
"endbody"       { currPos += yyleng; return END_BODY; }
"integer"       { currPos += yyleng; return INTEGER; }
"array"         { currPos += yyleng; return ARRAY; }
"of"            { currPos += yyleng; return OF; }
"if"            { currPos += yyleng; return IF; }
"then"          { currPos += yyleng; return THEN; }
"endif"         { currPos += yyleng; return ENDIF; }
"else"          { currPos += yyleng; return ELSE; }
"while"         { currPos += yyleng; return WHILE; }
"do"            { currPos += yyleng; return DO; }
"beginloop"     { currPos += yyleng; return BEGINLOOP; }
"endloop"       { currPos += yyleng; return ENDLOOP; }
"continue"      { currPos += yyleng; return CONTINUE; }
"read"          { currPos += yyleng; return READ; }
"write"         { currPos += yyleng; return WRITE; }
"and"           { currPos += yyleng; return AND; }
"or"            { currPos += yyleng; return OR; }
"not"           { currPos += yyleng; return NOT; }
"true"          { currPos += yyleng; return TRUE; }
"false"         { currPos += yyleng; return FALSE; }
"return"        { currPos += yyleng; return RETURN; }
"-"             { currPos += yyleng; return SUB; }
"+"             { currPos += yyleng; return ADD; }
"*"             { currPos += yyleng; return MULT; }
"/"             { currPos += yyleng; return DIV; }
"%"             { currPos += yyleng; return MOD; }
"=="            { currPos += yyleng; return EQ; }
"<>"            { currPos += yyleng; return NEQ; }
"<"             { currPos += yyleng; return LT; }
">"             { currPos += yyleng; return GT; }
"<="            { currPos += yyleng; return LTE; }
">="            { currPos += yyleng; return GTE; }
";"             { currPos += yyleng; return SEMICOLON; }
":"             { currPos += yyleng; return COLON; }
","             { currPos += yyleng; return COMMA; }
"("             { currPos += yyleng; return L_PAREN; }
")"             { currPos += yyleng; return R_PAREN; }
"["             { currPos += yyleng; return L_SQUARE_BRACKET; }
"]"             { currPos += yyleng; return R_SQUARE_BRACKET; }
":="            { currPos += yyleng; return ASSIGN; }

{ident}         { currPos += yyleng; return IDENT; }
{digits}+       { currPos += yyleng; yylval.int_val = atoi(yytext); return NUMBER; }
{hash}          { currPos += yyleng; }
{tab}+          { currPos += yyleng; }
{newline}       { currLine++; currPos = 1; }
{whitespace}+   { currPos += yyleng; }


{underLast}     { printf("Error at line %d, column %d: incorrect identifer (Underscore last) \"%s\"\n", currLine, currPos, yytext); exit(0); }
{underFirst}    { printf("Error at line %d, column %d: incorrect identifer (Underscore first) \"%s\"\n", currLine, currPos, yytext); exit(0); }
{digitFirst}    { printf("Error at line %d, column %d: incorrect identifer (Digit first) \"%s\"\n", currLine, currPos, yytext); exit(0); }
.               { printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0); }

%%
