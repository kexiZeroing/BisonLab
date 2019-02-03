#include <stdio.h>
int yylineno;
int errorCount = 0;

FILE *yyin;

/*
 * local variables (a listing of variables used in Demo)
 */
#define MAXVARS 100
static char* vars[MAXVARS];
static int nVars = 0;

// must have yyerror, yywrap
int yyerror (const char *s) {	
	errorCount += 1;
	fprintf(stderr, "\nLine %d has an error: %s\n", yylineno, s);
}

int yywrap (void) {return 1;}  // means end

char* findVar(char *varname) {
	if ( varname == NULL )
		return NULL;
	for (int i = 0; i < nVars; i++){
		if ( strcmp(vars[i], varname) == 0 )
			return vars + i;
	}

	return NULL;
}

char* addVar(char *varname) {
  if ( varname == NULL )
    return NULL;

  vars[nVars] = malloc(strlen(varname)+1);

  strcpy(vars[nVars], varname);
  nVars += 1;

  return vars + nVars - 1;
}

char* VarGet(char* varname) {
  	char* var;

  	var = findVar(varname);
	if ( var == NULL )
		var = addVar(varname);
	return var;
}


int main (int argc, char* argv[]) {
	int printHelp = 0;
	int printVar = 0;
	// ./demo -h test.demo
	if (argc == 3) {
		char *tmpH = "-h";
		char *tmpS = "-s";
		if (strcmp(argv[1], tmpH) == 0){
			printHelp = 1;
			yyin = fopen(argv[2], "r");
			if (!yyin){
				printf("error, unable to open file %s", argv[2]);
				return 0;
			}
		}else if(strcmp(argv[1], tmpS) == 0){
			printVar = 1;
			printHelp = 1;
			yyin = fopen(argv[2], "r");
			if (!yyin){
				printf("error, unable to open file %s", argv[2]);
				return 0;
			}
		}else if(argv[1][0] == '-'){
			printf("no option '-%c', please use -h to check.\n", argv[1][1]);
			return 0;
		}else {
			printf("wrong parameter, please use -h to check.\n");
			return 0;
		}
	}
	// ./demo -h  or ./demo a.demo
	else if(argc == 2) {
		char *tmpH = "-h";
		if (strcmp(argv[1], tmpH) == 0){
			printHelp = 1;
		}else if(argv[1][0] == '-'){
			printf("no option '-%c', please use -h to check.\n", argv[1][1]);
			return 0;
		}else {
			yyin = fopen(argv[1], "r");
			if(!yyin) {
				printf("error, unable to open file %s", argv[1]);
				return 0;
			}
		}
	}

	// handle all printHelp
	if (printHelp == 1){
        printf("========== Command help start ==========\n");
        printf("./demo -h: check command line syntax\n");
        printf("./demo filename: compile target file\n");
		printf("./demo -s filename: compile and list variables in the program\n");
        printf("./demo: compile from stdin, ^D to EOF\n");
		printf("========== Command help end ==========\n");

		if(argc == 2) {
			return 0;
		}
    }

	yyparse();

	if (errorCount == 0) {
		printf("Parse succeeds!\n");  //ctrl+d if use stdin
		if(printVar == 1){
			printf("======== Variable Name in Program ========\n");
			for (int i=0; i<nVars; i++)
				printf("%s \n", vars[i]);
		}
	} else {
		printf("Parser fails. Total number of errors: %d\n", errorCount);
	}
	return 0;
}