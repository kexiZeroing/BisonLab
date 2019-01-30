#include <stdio.h>
int yylineno;
int succFlag;
int errorCount = 0;

// must have yyerror, yywrap
int yyerror (const char *s) {	
	errorCount += 1;
	fprintf(stderr, "\nLine %d has an error: %s\n", yylineno, s);
}

int yywrap (void) {return 1;}  // means end

int main (int argc, char* argv[]) {
	if (argc == 2) {

	}

	succFlag = yyparse();

	if (errorCount == 0) {
		printf("Parse Successfully.\n");  //ctrl+d if use stdin
	} else {
		printf("Parser fails. Total number of errors: %d.\n", errorCount);
	}
	return 0;
}