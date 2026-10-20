#include <stdio.h>
#include "parser.tab.h"

int main(void)
{
    printf("Enter a Boolean expression:\n");
    return yyparse();
}
