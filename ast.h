#ifndef AST_H
#define AST_H

typedef struct ASTNode {
    char *value;
    struct ASTNode *left;
    struct ASTNode *right;
} ASTNode;

ASTNode *createNode(const char *value, ASTNode *left, ASTNode *right);
ASTNode *createNumberNode(int value);
void printPerfectGeometricTree(ASTNode *root);

#endif
