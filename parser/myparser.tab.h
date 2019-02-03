/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PROCEDURE = 258,
     INT = 259,
     CHAR = 260,
     WRITE = 261,
     READ = 262,
     AND = 263,
     OR = 264,
     NOT = 265,
     IF = 266,
     ELSE = 267,
     THEN = 268,
     FOR = 269,
     TO = 270,
     BY = 271,
     WHILE = 272,
     LT = 273,
     LE = 274,
     EQ = 275,
     NE = 276,
     GT = 277,
     GE = 278,
     NAME = 279,
     NUMBER = 280,
     CHARCONST = 281
   };
#endif
/* Tokens.  */
#define PROCEDURE 258
#define INT 259
#define CHAR 260
#define WRITE 261
#define READ 262
#define AND 263
#define OR 264
#define NOT 265
#define IF 266
#define ELSE 267
#define THEN 268
#define FOR 269
#define TO 270
#define BY 271
#define WHILE 272
#define LT 273
#define LE 274
#define EQ 275
#define NE 276
#define GT 277
#define GE 278
#define NAME 279
#define NUMBER 280
#define CHARCONST 281




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 11 "myparser.y"
{
  double  value;
  char    *string;
}
/* Line 1529 of yacc.c.  */
#line 106 "myparser.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

