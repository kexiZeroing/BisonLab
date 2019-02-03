#include <stdio.h>
int yylineno;
int errorCount = 0;

FILE *yyin;

// must have yyerror, yywrap
int yyerror (const char *s) {	
	errorCount += 1;
	fprintf(stderr, "\nLine %d has an error: %s\n", yylineno, s);
}

int yywrap (void) {return 1;}  // means end

int main (int argc, char* argv[]) {
	int printHelp = 0;
	// ./demo -h test.demo
	if (argc == 3) {
		char *tmp = "-h";
		if (strcmp(argv[1], tmp) == 0 ){
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
		char *tmp = "-h";
		if (strcmp(argv[1], tmp) == 0 ){
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
        printf("======== Command help start ========\n");
        printf("./demo -h: check command line syntax\n");
        printf("./demo filename: compile target file\n");
        printf("./demo: compile from stdin, ^D to EOF\n");
		printf("======== Command help end ========\n");
		return 0;
    }

	yyparse();

	if (errorCount == 0) {
		printf("Parse succeeds!\n");  //ctrl+d if use stdin
	} else {
		printf("Parser fails. Total number of errors: %d\n", errorCount);
	}
	return 0;
}