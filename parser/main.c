#include <stdio.h>
int yylineno;
int errorCount = 0;

FILE *yyin;

/*
 * local variables at most 100 (a listing of variables used in Demo)
 */
#define MAXVARS 100
static char* vars[MAXVARS];  // store variable address
static int numVars = 0;

// must have yyerror, yywrap
int yyerror (const char *s) {	
	errorCount += 1;
	fprintf(stderr, "\nLine %d has an error: %s\n", yylineno, s);
}

int yywrap (void) {return 1;}  // means end

// find if the varname is already in vars, return addr of the variable
char* findVar(char *varname) {
	if (varname == NULL)
		return NULL;
	int i;
	for (i = 0; i < numVars; i++){
		if (strcmp(vars[i], varname) == 0)  // already exists
			return vars + i;
	}

	return NULL;
}

// add the new variable to vars, return addr of the variable
char* addVar(char *varname) {
  if (varname == NULL)
    return NULL;

	if (numVars >= MAXVARS) {
		fprintf (stderr, "The maximum number %d of variables reached\n", MAXVARS);
		return NULL;
	}

	vars[numVars] = malloc(strlen(varname) + 1);  // last pos store the addr of new space
	strcpy(vars[numVars], varname);
	numVars++;

	return vars + numVars - 1;  // base addr + offset
}

// get a variable name from parser, add to vars if it is a new one 
void getVar(char* varname) {
  	char* var;

  	var = findVar(varname);
	if (var == NULL)
		var = addVar(varname);
}


int main (int argc, char* argv[]) {
	int printHelp = 0;
	int printVar = 0;
	// ./demo -h test1.demo
	if (argc == 3) {
		char *tmpH = "-h";
		char *tmpS = "-s";
		if (strcmp(argv[1], tmpH) == 0){
			printHelp = 1;
			yyin = fopen(argv[2], "r");
			if (!yyin){
				printf("error, unable to open file %s\n", argv[2]);
				return 0;
			}
		}else if(strcmp(argv[1], tmpS) == 0){
			printVar = 1;
			yyin = fopen(argv[2], "r");
			if (!yyin){
				printf("error, unable to open file %s\n", argv[2]);
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
	// ./demo -h  or ./demo test1.demo
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
				printf("error, unable to open file %s\n", argv[1]);
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
		// print all the variables 
		if(printVar == 1){
			printf("======== Variable Name in Program ========\n");
			int i;
			for (i=0; i<numVars; i++)
				printf("%s \n", vars[i]);
		}
	} else {
		printf("Parser fails. Total number of errors: %d\n", errorCount);
	}
	return 0;
}