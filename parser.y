
%code requires {
    typedef struct ASTNode {
        char *value;
        struct ASTNode *left;
        struct ASTNode *right;
    } ASTNode;
}

%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

ASTNode *createNode(const char *value, ASTNode *left, ASTNode *right);
ASTNode *createNumberNode(int value);
void printPerfectGeometricTree(ASTNode *root);
int evaluateAST(ASTNode *node);
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

ASTNode *createNode(const char *value, ASTNode *left, ASTNode *right)
{
    ASTNode *node = malloc(sizeof(ASTNode));

    if (node == NULL) {
        fprintf(stderr, "Memory allocation failed!\n");
        exit(EXIT_FAILURE);
    }

    node->value = (char *)value;
    node->left = left;
    node->right = right;

    return node;
}

ASTNode *createNumberNode(int value)
{
    char *text = malloc(20);

    if (text == NULL) {
        fprintf(stderr, "Memory allocation failed!\n");
        exit(EXIT_FAILURE);
    }

    snprintf(text, 20, "%d", value);

    return createNode(text, NULL, NULL);
}

/* Recursively print every AST node and its children */
static void printTreeBranch(ASTNode *node, const char *prefix,
                            int isLast)
{
    if (node == NULL)
        return;

    printf("%s%s%s\n",
           prefix,
           isLast ? "`-- " : "|-- ",
           node->value);

    char childPrefix[1024];

    snprintf(childPrefix, sizeof(childPrefix), "%s%s",
             prefix, isLast ? "    " : "|   ");

    if (node->left != NULL && node->right != NULL) {
        printTreeBranch(node->left, childPrefix, 0);
        printTreeBranch(node->right, childPrefix, 1);
    } else if (node->left != NULL) {
        printTreeBranch(node->left, childPrefix, 1);
    } else if (node->right != NULL) {
        printTreeBranch(node->right, childPrefix, 1);
    }
}

void printPerfectGeometricTree(ASTNode *root)
{
    if (root == NULL)
        return;

    printf("%s\n", root->value);

    if (root->left != NULL && root->right != NULL) {
        printTreeBranch(root->left, "", 0);
        printTreeBranch(root->right, "", 1);
    } else if (root->left != NULL) {
        printTreeBranch(root->left, "", 1);
    } else if (root->right != NULL) {
        printTreeBranch(root->right, "", 1);
    }
}

int evaluateAST(ASTNode *node)
{
    if (node == NULL)
        return 0;

    if (strcmp(node->value, "true") == 0)
        return 1;

    if (strcmp(node->value, "false") == 0)
        return 0;

    if (strcmp(node->value, ">") == 0)
        return atoi(node->left->value) > atoi(node->right->value);

    if (strcmp(node->value, "<") == 0)
        return atoi(node->left->value) < atoi(node->right->value);

    if (strcmp(node->value, ">=") == 0)
        return atoi(node->left->value) >= atoi(node->right->value);

    if (strcmp(node->value, "<=") == 0)
        return atoi(node->left->value) <= atoi(node->right->value);

    if (strcmp(node->value, "==") == 0)
        return atoi(node->left->value) == atoi(node->right->value);

    if (strcmp(node->value, "!=") == 0)
        return atoi(node->left->value) != atoi(node->right->value);

    if (strcmp(node->value, "&&") == 0)
        return evaluateAST(node->left) && evaluateAST(node->right);

    if (strcmp(node->value, "||") == 0)
        return evaluateAST(node->left) || evaluateAST(node->right);

    if (strcmp(node->value, "!") == 0)
        return !evaluateAST(node->left);

    return 0;
}

void yyerror(const char *s)
{
    (void)s;
    printf("Invalid Boolean expression!\n");
}

int main(void)
{
    printf("Enter a Boolean expression:\n");
    return yyparse();
}

