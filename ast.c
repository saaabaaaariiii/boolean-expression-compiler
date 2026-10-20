#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

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

/* Recursively print each AST node and its children */
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
