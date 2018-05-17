/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    LT = 258,
    LTE = 259,
    GT = 260,
    GTE = 261,
    EQ = 262,
    NEQ = 263,
    MULT = 264,
    DIV = 265,
    ADD = 266,
    SUB = 267,
    MOD = 268,
    NOT = 269,
    AND = 270,
    OR = 271,
    ASSIGN = 272,
    FUNCTION = 273,
    BEGINPARAMS = 274,
    ENDPARAMS = 275,
    BEGINLOCALS = 276,
    ENDLOCALS = 277,
    BEGINBODY = 278,
    ENDBODY = 279,
    INTEGER = 280,
    ARRAY = 281,
    OF = 282,
    IF = 283,
    THEN = 284,
    ENDIF = 285,
    ELSE = 286,
    WHILE = 287,
    DO = 288,
    FOREACH = 289,
    IN = 290,
    BEGINLOOP = 291,
    ENDLOOP = 292,
    CONTINUE = 293,
    READ = 294,
    WRITE = 295,
    TRUE = 296,
    FALSE = 297,
    SEMICOLON = 298,
    COLON = 299,
    COMMA = 300,
    L_SQUARE_BRACKET = 301,
    R_SQUARE_BRACKET = 302,
    RETURN = 303,
    MINUS = 304,
    EQUAL = 305,
    L_PAREN = 306,
    R_PAREN = 307,
    END = 308,
    NUMBER = 309,
    IDENT = 310
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 18 "mini_l.y" /* yacc.c:1909  */

  int int_val;
  char*  token_val;

#line 115 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
