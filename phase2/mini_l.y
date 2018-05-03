



%{
  #include <stdio.h>
  #include <stdlib.h>
  void yyerror(const char *msg);
  extern int currLine;
  extern int currPos;
  FILE * yyin;
%}

%union{
  int int_val;
  char*  token_val;
}

%error-verbose
%start program
%token MULT DIV MINUS EQUAL L_PAREN R_PAREN END
%token <int_val> NUMBER
%type <int_val> exp
%left PLUS MINUS
%left MULT DIV

%%
program:

input:		| input line
		;

line:		exp EQUAL END			{printf("\t%d\n", $1);}
		;

exp:		NUMBER				{$$ = $1;}
			| exp PLUS exp		{$$ = $1 + $3;}
			| exp MINUS exp		{$$ = $1 - $3;}
			| exp MULT exp		{$$ = $1 * $3;}
			| exp DIV exp		{if ($3==0) yyerror("divide by zero"); else $$ = $1 / $3;}
			| L_PAREN exp R_PAREN	{$$ = $2;}
			;
%%

int main(int argc, char **argv) {
   if(argc > 1) {
     yyin = fopen(argv[1], "r");
     if (yyin == NULL) {
        printf("syntax: %s filename\n", argv[0]); 
     }
   }
   yyparse(); //calls yylex() for tokens
   return 0;
}

void yyerror(const char *msg) {
   print("** Line %d: %s\n", currLine, currPos, msg);
}
