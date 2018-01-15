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

#ifndef YY_YY_OUT_PCLANG_TAB_H_INCLUDED
# define YY_YY_OUT_PCLANG_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_PROGRAM = 258,
    T_EQUAL = 259,
    T_IS_NOT = 260,
    T_NOT_EQUAL = 261,
    T_BOOL_AND = 262,
    T_BOOL_OR = 263,
    T_OPEN_PARAN = 264,
    T_CLOSE_PARAN = 265,
    T_OPEN_CURLY = 266,
    T_CLOSE_CURLY = 267,
    T_OPEN_SQUARE = 268,
    T_CLOSE_SQUARE = 269,
    T_MUL = 270,
    T_ADD = 271,
    T_SUB = 272,
    T_DIV = 273,
    T_MOD = 274,
    T_GREATER = 275,
    T_GREATER_OR_EQUAL = 276,
    T_LESS = 277,
    T_LESS_OR_EQUAL = 278,
    T_ASSIGN = 279,
    T_SEMICOLON = 280,
    T_COMMA = 281,
    T_DECLARE = 282,
    T_CONST = 283,
    T_AS = 284,
    T_READ = 285,
    T_WRITE = 286,
    T_WHILE = 287,
    T_IF = 288,
    T_CHAR = 289,
    T_INT = 290,
    T_ID = 291,
    T_CONST_INT = 292,
    T_CONST_STR = 293
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 19 "pclang.y" /* yacc.c:1909  */

	int i_val;
	float fval;
	char *s_val;

#line 99 "out/pclang.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_OUT_PCLANG_TAB_H_INCLUDED  */
