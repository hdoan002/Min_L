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
"array"         { return ARRAY; currPos += yyleng; }
"of"            { return OF; currPos += yyleng; }
"if"            { return IF; currPos += yyleng; }
"then"          { return THEN; currPos += yyleng; }
"endif"         { return ENDIF; currPos += yyleng; }
"else"          { return ELSE; currPos += yyleng; }
"while"         { return WHILE; currPos += yyleng; }
"do"            { return DO; currPos += yyleng; }
"beginloop"     { return BEGINLOOP; currPos += yyleng; }
"endloop"       { return ENDLOOP; currPos += yyleng; }
"continue"      { return CONTINUE; currPos += yyleng; }
"read"          { return READ; currPos += yyleng; }
"write"         { return WRITE; currPos += yyleng; }
"and"           { return AND; currPos += yyleng; }
"or"            { return OR; currPos += yyleng; }
"not"           { return NOT; currPos += yyleng; }
"true"          { return TRUE; currPos += yyleng; }
"false"         { return FALSE; currPos += yyleng; }
"return"        { return RETURN; currPos += yyleng; }
"-"             { return SUB; currPos += yyleng; }
"+"             { return ADD; currPos += yyleng; }
"*"             { return MULT; currPos += yyleng; }
"/"             { return DIV; currPos += yyleng; }
"%"             { return MOD; currPos += yyleng; }
"=="            { return EQ; currPos += yyleng; }
"<>"            { return NEQ; currPos += yyleng; }
"<"             { return LT; currPos += yyleng; }
">"             { return GT; currPos += yyleng; }
"<="            { return LTE; currPos += yyleng; }
">="            { return GTE;  currPos += yyleng; }
";"             { return SEMICOLON; currPos += yyleng; }
":"             { return COLON; currPos += yyleng; }
","             { return COMMA; currPos += yyleng; }
"("             { return L_PAREN; currPos += yyleng; }
")"             { return R_PAREN; currPos += yyleng; }
"["             { return L_SQUARE_BRACKET; currPos += yyleng; }
"]"             { return R_SQUARE_BRACKET; currPos += yyleng; }
":="            { return ASSIGN; currPos += yyleng; }

{ident}         { return IDENT; currPos += yyleng; }
{digits}+       { return NUMBER; currPos += yyleng; yylval.int_val = atoi(yytext); }
{hash}          { currPos += yyleng; }
{tab}+          { currPos += yyleng; }
{newline}       { currLine++; currPos = 1; }
{whitespace}+   { currPos += yyleng; }


{underLast}     { printf("Error at line %d, column %d: incorrect identifer (Underscore last) \"%s\"\n", currLine, currPos, yytext); exit(0); }
{underFirst}    { printf("Error at line %d, column %d: incorrect identifer (Underscore first) \"%s\"\n", currLine, currPos, yytext); exit(0); }
{digitFirst}    { printf("Error at line %d, column %d: incorrect identifer (Digit first) \"%s\"\n", currLine, currPos, yytext); exit(0); }
.               { printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0); }

%%
