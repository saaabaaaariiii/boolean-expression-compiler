%{
#include <stdio.h>
#include "parser.tab.h"
%}

%option noyywrap

%%
[0-9]+          { yylval.number = atoi(yytext); return NUMBER; }
"true"          { return TRUE; }
"false"         { return FALSE; }
"&&"            { return AND; }
"||"            { return OR; }
"=="            { return EQ; }
"!="            { return NE; }
">="            { return GE; }
"<="            { return LE; }
">"             { return GT; }
"<"             { return LT; }
"!"             { return NOT; }
"("             { return '('; }
")"             { return ')'; }
[ \t]+          ;
\n    { return 0; }    
.               { return yytext[0]; }
%%

