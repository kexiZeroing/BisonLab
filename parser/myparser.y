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
			| PROCEDURE NAME '{' Decls Stmts { yyerror("Missing procedure closing curly brace '}'"); }
			| PROCEDURE NAME '{' Decls Stmts '}' '}' { yyerror("unexpected '}', redundant closing curly brace found"); yyclearin; }
			;
Decls 		: Decls Decl ';' 
	 		| Decl ';' 
			| Decls Decl { yyerror("Missing semicolon after declaration"); }
			| Decl  { yyerror("Missing semicolon after declaration"); }
			| Decls Decl ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; }
			| Decl ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; }
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
			| '{' '}' { yyerror("Empty statement list is not allowed"); yyclearin; }
			| '{' ';' '}' { yyerror("Empty statement in a list is not allowed"); yyclearin; }
			| Reference '+' '=' Expr ';' { yyerror("Do not support '+=', only use '=' in assignment"); yyclearin; } 
			| Reference '=' Expr ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; 
			}
			| WRITE '=' Expr ';' { yyerror("unexpected EQUALS, expecting CHARCONST or '(' or NAME or NUMBER, could not make an assignment to write"); yyclearin; }
			| NAME NAME ';' { yyerror("unexpected NAME. No such reserved word"); yyclearin; }
			| IF '(' Bool ')' error  { yyerror("Missing keyword THEN"); /* just forget keyword then, do not need to throw away token */ }
			| IF '(' Bool ')' THEN '{' Stmts error { yyerror("Missing closing curly brace '}'"); }
			| Reference '=' Expr error { yyerror("Missing semicolon ';' after assignment"); }
			| error ';'  { yyerror("Do not support this statement"); yyclearin; yyerrok; }
			;
WithElse	: IF '(' Bool ')' THEN WithElse ELSE WithElse
			| Reference '=' Expr ';' 
			| '{' Stmts '}'
			| WHILE '(' Bool ')' '{' Stmts '}' 
			| FOR NAME '=' Expr TO Expr BY Expr '{' Stmts '}' 
			| READ Reference ';'
			| WRITE Expr ';'
			| '{' '}' { yyerror("Empty statement list is not allowed"); yyclearin; }
			| '{' ';' '}' { yyerror("Empty statement in a list is not allowed"); yyclearin; }
			| Reference '+' '=' Expr ';' { yyerror("Do not support '+=', only use '=' in assignment"); yyclearin; } 
			| Reference '=' Expr ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; 
			}
			| WRITE '=' Expr ';' { yyerror("can not make an assignment to write"); yyclearin; }
			| NAME NAME ';' { yyerror("No such reserved word"); yyclearin; }
			| IF '(' Bool ')' error  { yyerror("Missing keyword THEN"); /* just forget keyword then, do not need to throw away token */ }
			| IF '(' Bool ')' THEN '{' Stmts error { yyerror("Missing closing curly brace '}'"); }
			| Reference '=' Expr error { yyerror("Missing semicolon ';' after assignment"); }
			| error ';'  { yyerror("Do not support this statement"); yyclearin; yyerrok; }
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
