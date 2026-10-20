#include <stdlib.h>
#include <string.h>
#include "semantic.h"

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

