/* C declarations */
%{
#include <stdio.h>
extern int yylineno;
extern int errorCount;
%}

/* Bison declarations */
%error-verbose

%union {
  double  value;
  char    *string;
}

%start Procedure
%token PROCEDURE
%token INT
%token CHAR
%token WRITE
%token READ
%token AND
%token OR
%token NOT
%token IF
%token ELSE
%token THEN
%token FOR
%token TO
%token BY
%token WHILE
%token LT
%token LE
%token EQ
%token NE
%token GT
%token GE
%token <string> NAME
%token NUMBER
%token CHARCONST


/* productions and actions */
%%
Procedure   : PROCEDURE NAME '{' Decls Stmts '}'
			| PROCEDURE NAME '{' Decls Stmts { yyerror("Missing procedure right curly brace '}'"); yyclearin;}
			| PROCEDURE NAME '{' Decls Stmts '}' '}' { yyerror("unexpected EOF"); yyclearin;}
			;
Decls 		: Decls Decl ';' 
	 		| Decl ';' 
			| Decls Decl { yyerror("Missing semicolon after declaration"); }
			| Decl  { yyerror("Missing semicolon after declaration"); }
	 		;
Decl		: Type SpecList
			;
Type		: INT
			| CHAR
			;
SpecList	: SpecList ',' Spec
			| Spec 
			;
Spec		: NAME  { getVar($1); }
			| NAME '[' Bounds ']' { getVar($1); }
			;
Bounds		: Bounds ',' Bound 
      		| Bound 
      		;
Bound		: NUMBER ':' NUMBER 
			;
Stmts		: Stmts Stmt 
	 		| Stmt 
	 		;
Stmt      	: Reference '=' Expr ';' 
			| '{' Stmts '}'
			| IF '(' Bool ')' THEN Stmt 
          	| IF '(' Bool ')' THEN WithElse ELSE Stmt 
			| WHILE '(' Bool ')' '{' Stmts '}' 
			| FOR NAME '=' Expr TO Expr BY Expr '{' Stmts '}' 
			| READ Reference ';'
			| WRITE Expr ';'
			| '{' '}' { yyerror("Empty statement list is not allowed"); }
			| '{' ';' '}' { yyerror("Empty statement in a list is not allowed"); }
			| Reference '=' Expr { yyerror("Missing semicolon after assignment"); }
			| NAME NAME ';' { yyerror("No such reserved word"); }
			| IF '(' Bool ')' Stmt  { yyerror("Missing keyword THEN"); }
			| error ';' { yyerrok; yyclearin; }
			;
WithElse	: IF '(' Bool ')' THEN WithElse ELSE WithElse
			| Reference '=' Expr ';' 
			| '{' Stmts '}'
			| WHILE '(' Bool ')' '{' Stmts '}' 
			| FOR NAME '=' Expr TO Expr BY Expr '{' Stmts '}' 
			| READ Reference ';'
			| WRITE Expr ';'
			| error ';' { yyerrok; yyclearin; }
			; 
Bool      	: NOT OrTerm
          	| OrTerm
			;
OrTerm		: OrTerm OR AndTerm
        	| AndTerm
			;
AndTerm   	: AndTerm AND RelExpr
          	| RelExpr
			;
RelExpr 	: RelExpr LT Expr
        	| RelExpr LE Expr
        	| RelExpr EQ Expr
        	| RelExpr NE Expr
        	| RelExpr GE Expr
        	| RelExpr GT Expr
        	| Expr
			| RelExpr '=' Expr { yyerror("Forgot an equal '=' in RelExprssion"); }
			;
Expr		: Expr '+' Term  
			| Expr '-' Term  
			| Term 
			;
Term		: Term '*' Factor 
			| Term '/' Factor 
			| Factor 
			;
Factor		: '(' Expr ')' 
         	| Reference
	  		| NUMBER 
	  		| CHARCONST 
	  		; 
Reference 	: NAME
          	| NAME '[' Exprs ']'
			;
Exprs     	: Expr ',' Exprs 
          	| Expr
			;

%%                    
 /* C code */
