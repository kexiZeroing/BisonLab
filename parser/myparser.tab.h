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
     WRITE = 258,
     READ = 259,
     AND = 260,
     OR = 261,
     NOT = 262,
     IF = 263,
     ELSE = 264,
     THEN = 265,
     FOR = 266,
     TO = 267,
     BY = 268,
     WHILE = 269,
     LT = 270,
     LE = 271,
     EQ = 272,
     NE = 273,
     GT = 274,
     GE = 275,
     NAME = 276,
     NUMBER = 277,
     CHARCONST = 278
   };
#endif
/* Tokens.  */
#define WRITE 258
#define READ 259
#define AND 260
#define OR 261
#define NOT 262
#define IF 263
#define ELSE 264
#define THEN 265
#define FOR 266
#define TO 267
#define BY 268
#define WHILE 269
#define LT 270
#define LE 271
#define EQ 272
#define NE 273
#define GT 274
#define GE 275
#define NAME 276
#define NUMBER 277
#define CHARCONST 278




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

