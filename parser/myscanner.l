%{
#include "myparser.tab.h"
%}

%%
"//".*                  ;
"write"                 { return WRITE; }
"=="                    { return EQ; }
">"                     { return GT; }
">="                    { return GE; }
"<"                     { return LT; }
"<="                    { return LE; }
"!="                    { return NE; }
"and"                   { return AND; }
"or"                    { return OR; }
"not"                   { return NOT; }
"if"                    { return IF; }
"then"                  { return THEN; }
"else"                  { return ELSE; }
";"                     { return ';'; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"("                     { return '('; }
")"                     { return ')'; }
"["                     { return '['; }
"]"                     { return ']'; }
","                     { return ','; }
[0-9]+                  { return NUMBER; }
[A-Za-z][A-Za-z0-9_]*   { return NAME; }
'(.|\\.)'               { return CHARCONST; }
[ \t]                   ;
[\n]                    { yylineno++; }


%%

