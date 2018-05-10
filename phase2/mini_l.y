



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

%token FUNCTION BEGINPARAMS ENDPARAMS BEGINLOCALS ENDLOCALS BEGINBODY ENDBODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE TRUE FALSE SEMICOLON COLON COMMA LPAREN RPAREN LSQUARE RSQUARE ASSIGN RETURN
%token MULT DIV MINUS EQUAL L_PAREN R_PAREN END
%token <int_val> NUMBER
%type <int_val> exp
%left LT LTE GT GTE EQ NEQ
%left MULT DIV PLUS MINUS
%right NOT
%left AND OR
%right ASSIGN


%%
program:	functions
		;

functions:	
		| function functions
		;

function:	FUNCTION IDENTIFIERS SEMICOLON BEGINPARAMS declarations ENDPARAMS BEGINLOCALS declarations ENDLOCALS BEGINBODY statements ENDBODY
		;

declarations:	
		| declaration SEMICOLON declarations
		;

declaration:	id colon assign
		;

id:		IDENTIFIERS
		| IDENTIFIERS COMMA
		;

assign:		INTEGER {printf("assign -> INTEGER\n");}
		| ARRAY LSQUARE NUMBERS RSQUARE OF INTEGER {printf("assign -> ARRAY LSQUARE NUMBER %d RSQUARE OF INTEGER\n", $3);}
		;

statements:	statement SEMICOLON statements
		| statement SEMICOLON
		;

statement:	a
		| b
		| c
		| d
		| e
		| f
		| g
		| h
		;

boolean_expr:	relation_exprr 
		| boolean_expr OR relation_exprr 
		;

relation_exprr:	relation_expr 
		| relation_exprr AND relation_expr 
		;

relation_expr:	rexpr 
		| NOT rexpr 
		;

rexpr:		expression comp expression 
		| TRUE 
		| FALSE 
		| L_PAREN boolean_expr R_PAREN 
		;

comp:		EQ 
		| NEQ 
		| LT 
		| GT 
		| LTE 
		| GTE 
		;

expression:	mul_expr expradd 
		;

expradd:	/*empty*/ 
		| ADD mul_expr expradd 
		| SUB mul_expr expradd 
		;

mul_expr:	term multi_term 
		;

multi_term:	/*empty*/ 
		| MULT term multi_term 
		| DIV term multi_term 
		| MOD term multi_term 
		;

term:           posterm 
                | SUB posterm 
                | IDENTIFIERS term_iden 
                ;

posterm:        var 
                | NUMBERS 
                | L_PAREN expression R_PAREN 
                ;

term_iden:      L_PAREN term_ex R_PAREN 
                | L_PAREN R_PAREN 
                ;

term_ex:        expression 
                | expression COMMA term_ex 
                ;

var:            IDENTIFIERS 
                | IDENTIFIERS LSQUARE expression RSQUARE  
                ;


input:		
		| input line
		;

line:		
		exp EQUAL END			{printf("\t%d\n", $1);}
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
