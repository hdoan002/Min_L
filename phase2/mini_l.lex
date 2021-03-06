/*
  Henry Doan - hdoan002@ucr.edu
  Steve Guardado - sguar001@ucr.edu
  CS152 - Phase 2
*/

%{
  #include "y.tab.h"
  int currLine = 1, currPos = 1;
%}

ALPHA           [a-zA-Z]
DIGIT         	[0-9]
TAB             [\t]
NEWLINE         [\n]
WHITESPACE      [ ]

INVALIDSTART	[0-9_]+([a-zA-Z0-9_]*[a-zA-Z0-9])
INVALIDEND	[a-zA-Z]([a-zA-Z0-9_]*[_])
IDENT		[a-zA-Z]([a-zA-Z0-9_]*[a-zA-Z0-9])*

%%

"+"			{currPos += yyleng; return ADD;}
"-"			{currPos += yyleng; return SUB;}
"*"			{currPos += yyleng; return MULT;}
"/"			{currPos += yyleng; return DIV;}
"%"			{currPos += yyleng; return MOD;}

"=="			{currPos += yyleng; return EQ;}
"<>"			{currPos += yyleng; return NEQ;}
"<"			{currPos += yyleng; return LT;}
">"			{currPos += yyleng; return GT;}
"<="			{currPos += yyleng; return LTE;}
">="			{currPos += yyleng; return GTE;}

"function"		{currPos += yyleng; return FUNCTION;}
"beginparams"		{currPos += yyleng; return BEGINPARAMS;}
"endparams"		{currPos += yyleng; return ENDPARAMS;}
"beginlocals"		{currPos += yyleng; return BEGINLOCALS;}
"endlocals"		{currPos += yyleng; return ENDLOCALS;}
"beginbody"		{currPos += yyleng; return BEGINBODY;}
"endbody"		{currPos += yyleng; return ENDBODY;}
"integer"		{currPos += yyleng; return INTEGER;}
"array"			{currPos += yyleng; return ARRAY;}
"of"			{currPos += yyleng; return OF;}
"if"			{currPos += yyleng; return IF;}
"then"			{currPos += yyleng; return THEN;}
"endif"			{currPos += yyleng; return ENDIF;}
"else"			{currPos += yyleng; return ELSE;}
"while"			{currPos += yyleng; return WHILE;}
"do"			{currPos += yyleng; return DO;}
"foreach"		{currPos += yyleng; return FOREACH;}
"in"			{currPos += yyleng; return IN;}
"beginloop"		{currPos += yyleng; return BEGINLOOP;}
"endloop"		{currPos += yyleng; return ENDLOOP;}
"continue"		{currPos += yyleng; return CONTINUE;}
"read"			{currPos += yyleng; return READ;}
"write"			{currPos += yyleng; return WRITE;}
"and"			{currPos += yyleng; return AND;}
"or"			{currPos += yyleng; return OR;}
"not"			{currPos += yyleng; return NOT;}
"true"			{currPos += yyleng; return TRUE;}
"false"			{currPos += yyleng; return FALSE;}
"return"		{currPos += yyleng; return RETURN;} 

";" 			{currPos += yyleng; return SEMICOLON;}
":" 			{currPos += yyleng; return COLON;}
"," 			{currPos += yyleng; return COMMA;}
"(" 			{currPos += yyleng; return L_PAREN;}
")" 			{currPos += yyleng; return R_PAREN;}
"[" 			{currPos += yyleng; return L_SQUARE_BRACKET;}
"]" 			{currPos += yyleng; return R_SQUARE_BRACKET;}
":=" 			{currPos += yyleng; return ASSIGN;}

{WHITESPACE}		{currPos += yyleng;}
{TAB}			{currPos += yyleng;}
{NEWLINE}		{currLine += 1; currPos = 1;}

{DIGIT}+		{yylval.int_val = atoi(yytext); currPos += yyleng; return NUMBER;}

{IDENT}			{currPos += yyleng; yylval.token_val = strdup(yytext); return IDENT;}

{INVALIDSTART}		{printf("Error at line %d, column %d: invalid IDENT \"%s\"\n", currLine, currPos, yytext); exit(0);}

{INVALIDEND}		{printf("Error at line %d, column %d: invalid IDENT \"%s\"\n", currLine, currPos, yytext); exit(0);}

[#][#].*		{currLine += 1; currPos = 1;}

.			{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}
%%
