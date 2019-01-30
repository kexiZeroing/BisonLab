/* C declarations */
%{

%}

/* Bison declarations */
%error-verbose

%start Stmts
%token AND
%token OR
%token NOT
%token IF
%token ELSE
%token THEN
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
Stmts		: Stmts Stmt 
	 		| Stmt 
	 		;
Stmt      	: IF '(' Bool ')' THEN Stmt 
          	| IF '(' Bool ')' THEN WithElse ELSE Stmt 
			| '{' Stmts '}'   
			;
WithElse	: IF '(' Bool ')' THEN WithElse ELSE WithElse
			| '{' Stmts '}'
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
	  		| NUMBER 
	  		| CHARCONST 
	  		; 


%%                    
 /* C code */
