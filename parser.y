
%code requires {
    #include "ast.h"
}

%{
#include "ast.h"
#include "semantic.h"
#include <stdio.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int number;
    ASTNode *node;
}

%token TRUE FALSE
%token AND OR NOT
%token GT LT GE LE EQ NE
%token <number> NUMBER

%type <node> expression conjunction unary primary comparison



%%

input:
    expression
    {
        printf("\nValid Boolean expression!\n");
        printf("Abstract Syntax Tree:\n");

        if ($1 != NULL) {
            printPerfectGeometricTree($1);

            if (evaluateAST($1))
                printf("\nResult: TRUE\n");
            else
                printf("\nResult: FALSE\n");
        }
    }
    ;

expression:
      expression OR conjunction
        { $$ = createNode("||", $1, $3); }
    | conjunction
        { $$ = $1; }
    ;

conjunction:
      conjunction AND unary
        { $$ = createNode("&&", $1, $3); }
    | unary
        { $$ = $1; }
    ;

unary:
      NOT unary
        { $$ = createNode("!", $2, NULL); }
    | primary
        { $$ = $1; }
    ;

primary:
      '(' expression ')'
        { $$ = $2; }
    | comparison
        { $$ = $1; }
    | TRUE
        { $$ = createNode("true", NULL, NULL); }
    | FALSE
        { $$ = createNode("false", NULL, NULL); }
    ;

comparison:
      NUMBER GT NUMBER
        { $$ = createNode(">", createNumberNode($1), createNumberNode($3)); }
    | NUMBER LT NUMBER
        { $$ = createNode("<", createNumberNode($1), createNumberNode($3)); }
    | NUMBER GE NUMBER
        { $$ = createNode(">=", createNumberNode($1), createNumberNode($3)); }
    | NUMBER LE NUMBER
        { $$ = createNode("<=", createNumberNode($1), createNumberNode($3)); }
    | NUMBER EQ NUMBER
        { $$ = createNode("==", createNumberNode($1), createNumberNode($3)); }
    | NUMBER NE NUMBER
        { $$ = createNode("!=", createNumberNode($1), createNumberNode($3)); }
    ;

%%

void yyerror(const char *s)
{
    (void)s;
    printf("Invalid Boolean expression!\n");
}

