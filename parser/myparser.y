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
			;
Decls 		: Decls Decl ';' 
	 		| Decl ';' 
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
			;
WithElse	: IF '(' Bool ')' THEN WithElse ELSE WithElse
			| Reference '=' Expr ';' 
			| '{' Stmts '}'
			| WHILE '(' Bool ')' '{' Stmts '}' 
			| FOR NAME '=' Expr TO Expr BY Expr '{' Stmts '}' 
			| READ Reference ';'
			| WRITE Expr ';'
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
