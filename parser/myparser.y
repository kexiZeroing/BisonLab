/* C declarations */
%{

%}

/* Bison declarations */
%error-verbose

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
%token NAME
%token NUMBER
%token CHARCONST


/* productions and actions */
%%
Procedure   : PROCEDURE NAME '{' Decls Stmts '}'
			| PROCEDURE NAME '{' Decls Stmts { yyerror("Forget procedure right curly brace '}'"); }
			;
Decls 		: Decls Decl ';' 
	 		| Decl ';' 
			| Decls Decl { yyerror("Forget semicolon after declaration"); }
			| Decl  { yyerror("Forget semicolon after declaration"); }
	 		;
Decl		: Type SpecList
			;
Type		: INT
			| CHAR
			;
SpecList	: SpecList ',' Spec
			| Spec 
			;
Spec		: NAME 
			| NAME '[' Bounds ']' 
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
			| Reference '=' Expr { yyerror("Forget semicolon after assignment"); }
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
