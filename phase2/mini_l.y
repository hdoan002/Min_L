/*
  Henry Doan - hdoan002@ucr.edu
  Steve Guardado - sguar001@ucr.edu
  CS152 - Phase 2
*/



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

%left LT LTE GT GTE EQ NEQ
%left MULT DIV ADD SUB MOD
%right NOT
%left AND OR
%right ASSIGN

%token FUNCTION BEGINPARAMS ENDPARAMS BEGINLOCALS ENDLOCALS BEGINBODY ENDBODY 
%token INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO FOREACH IN BEGINLOOP ENDLOOP CONTINUE 
%token READ WRITE TRUE FALSE SEMICOLON COLON COMMA L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN RETURN
%token MULT DIV MINUS EQUAL L_PAREN R_PAREN END
%token <int_val> NUMBER
%token <token_val> IDENT

%%
program:	
		functions {printf("program -> functions\n");}
		;

functions:	
		{printf("functions -> epsilon\n");}
		| function functions {printf("functions -> function functions\n");}
		;

function:	
		FUNCTION IDENT SEMICOLON BEGINPARAMS declarations ENDPARAMS BEGINLOCALS declarations ENDLOCALS BEGINBODY statements ENDBODY {
		printf("function-> FUNCTION IDENT SEMICOLON BEGINPARAMS declarations ENDPARAMS BEGINLOCALS declarations ENDLOCALS BEGINBODY statements ENDBODY\n");}
		| error {yyerrok; yyclearin;}
		;

declarations:	
		{printf("declarations -> epsilon\n");}
		| declaration SEMICOLON declarations {printf("declarations -> declaration SEMICOLON declarations\n");}
		;

declaration:	
		IDENT identifiers COLON INTEGER {printf("declaration -> IDENT identifiers COLON INTEGER\n");}
		| IDENT identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("declaration -> IDENT identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
		| error {yyerrok; yyclearin;}
		;

identifiers:	
		{printf("identifiers -> epsilon\n");}
		| COMMA IDENT identifiers {printf("identifiers -> identifier COMMA identifiers\n");}
		;

statements:	
		statement SEMICOLON statements
		| statement SEMICOLON
		;

statement:  
		var ASSIGN expression {printf("statement -> var ASSIGN expression\n");}
		| IF bool_exp THEN statements ENDIF {printf("statement -> IF bool_exp THEN statements ENDIF\n");}
		| IF bool_exp THEN statements ELSE statements ENDIF {printf("statement -> IF bool_exp THEN statements ELSE statements ENDIF\n");}
		| WHILE bool_exp BEGINLOOP statements ENDLOOP {printf("statement -> WHILE bool_exp BEGINLOOP statements ENDLOOP\n");}
		| DO BEGINLOOP statements ENDLOOP WHILE bool_exp {printf("statement -> DO BEGINLOOP statements ENDLOOP WHILE bool_exp\n");}
		| FOREACH IDENT IN IDENT BEGINLOOP statements ENDLOOP {printf("statement -> FOREACH IDENT IN IDENT BEGINLOOP statements ENDLOOP\n");}
		| READ var vars {printf("statement -> READ vars\n");}
		| WRITE var vars {printf("statement -> WRITE vars\n");}
		| CONTINUE {printf("statement -> CONTINUE\n");}
		| RETURN expression {printf("statement -> RETURN expression\n");}
		| error {yyerrok; yyclearin;}
		;

bool_exp:	
		relation_and_exp {printf("bool_exp -> relation_and_exp\n");}
		| bool_exp OR relation_and_exp {printf("bool_exp -> bool_exp OR relation_and_exp\n");}
		;

relation_and_exp:	
			relation_exp1 {printf("relation_and_exp -> relation_exp\n");} 
			| relation_and_exp AND relation_exp1 {printf("relation_and_exp -> relation_and_exp AND relation_exp\n");}	 
			;

relation_exp1:	
		relation_exp2 {printf("relation_exp -> relation_exp\n");}
		| NOT relation_exp2 {printf("relation_exp -> NOT relation_exp\n");}
		;

relation_exp2:	
		expression comp expression {printf("relation_exp -> expression comp expression\n");}
		| TRUE {printf("relation_exp -> TRUE\n");}
		| FALSE {printf("relation_exp -> FALSE\n");}
		| L_PAREN bool_exp R_PAREN {printf("relation_exp -> L_PAREN bool_exp R_PAREN\n");}
		;

comp:		
		EQ {printf("comp -> EQ\n");}
		| NEQ {printf("comp -> NEQ\n");}
		| LT {printf("comp -> LT\n");}
		| GT {printf("comp -> GT\n");}
		| LTE {printf("comp -> LTE\n");}
		| GTE {printf("comp -> GTE\n");}
		;

expression:	
		multiplicative_exp addition_exp {printf("expression -> multiplicative_exp addition_exp\n");}
		;

addition_exp:	
		{printf("addition_exp -> epsilon\n");} 
		| ADD multiplicative_exp addition_exp {printf("expression -> multiplicative_exp ADD multiplicative_exp\n");}
		| SUB multiplicative_exp addition_exp {printf("expression -> multiplicative_exp SUB multiplicative_exp\n");}
		;

multiplicative_exp:	term multi_term {printf("multiplicative_exp -> term\n");}
		;

multi_term:	
		{printf("multi_term -> epsilon\n");}
		| MOD term multi_term {printf("mult_term -> MOD term multi_term\n");}
		| DIV term multi_term {printf("mult_term -> DIV term multi_term\n");}
		| MULT term multi_term {printf("mult_term -> MULT term multi_term\n");}
		;

term:           
		posterm {printf("term -> posterm\n");} 
                | SUB posterm {printf("term -> SUB posterm\n");}
 		| IDENT L_PAREN R_PAREN {printf("term -> IDENT L_PAREN R_PAREN\n");}
		| IDENT L_PAREN expression expressions R_PAREN {printf("term -> IDENT L_PAREN expression expressions R_PAREN\n");}
		;

posterm:        
		var {printf("posterm -> var\n");} 
                | NUMBER {printf("posterm -> NUMBER %d\n", $1);}
                | L_PAREN expression R_PAREN {printf("posterm -> L_PAREN expression R_PAREN\n");}
                ;

expressions:    
		{printf("expressions -> epsilon\n");}
                | expression COMMA expressions {printf("expressions -> expression COMMA expressions\n");}
                ;

var:            
		IDENT {printf("var -> IDENT %s\n", $1);}
                | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}  
                ;

vars:
		{printf("vars -> epsilon\n");}
		| COMMA var vars {printf("vars -> COMMA var vars\n");}
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
   printf("** Line %d, position %d: %s\n", currLine, currPos, msg);
}
