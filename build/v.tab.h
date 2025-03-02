/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_V_TAB_H_INCLUDED
# define YY_YY_V_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    NUMBER = 258,                  /* NUMBER  */
    VARIABLE = 259,                /* VARIABLE  */
    STRING = 260,                  /* STRING  */
    WHILE = 261,                   /* WHILE  */
    FOR = 262,                     /* FOR  */
    IF = 263,                      /* IF  */
    THEN = 264,                    /* THEN  */
    PRINT = 265,                   /* PRINT  */
    ASSIGN = 266,                  /* ASSIGN  */
    EXIT = 267,                    /* EXIT  */
    RANDOM = 268,                  /* RANDOM  */
    PI = 269,                      /* PI  */
    SCAN = 270,                    /* SCAN  */
    LOG = 271,                     /* LOG  */
    EXP = 272,                     /* EXP  */
    SQRT = 273,                    /* SQRT  */
    FLOOR = 274,                   /* FLOOR  */
    CEIL = 275,                    /* CEIL  */
    ABS = 276,                     /* ABS  */
    SIN = 277,                     /* SIN  */
    ASIN = 278,                    /* ASIN  */
    COS = 279,                     /* COS  */
    ACOS = 280,                    /* ACOS  */
    TAN = 281,                     /* TAN  */
    ATAN = 282,                    /* ATAN  */
    IFX = 283,                     /* IFX  */
    ELSE = 284,                    /* ELSE  */
    AND = 285,                     /* AND  */
    OR = 286,                      /* OR  */
    GE = 287,                      /* GE  */
    LE = 288,                      /* LE  */
    NE = 289,                      /* NE  */
    NOT = 290,                     /* NOT  */
    UMINUS = 291                   /* UMINUS  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 24 "v.y"

    double dValue;
    char *sValue;
    char *vName;
    nodeType *nPtr;

#line 107 "v.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_V_TAB_H_INCLUDED  */
