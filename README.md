# Boolean Expression Compiler

## Overview

The Boolean Expression Compiler is a mini compiler front-end developed using C, Flex, and Bison. It recognizes Boolean expressions, constructs an Abstract Syntax Tree (AST), and evaluates the expression to produce a Boolean result.

## Features

- Lexical analysis using Flex
- Syntax analysis using Bison
- Boolean constants: `true`, `false`
- Relational operators: `>`, `<`, `>=`, `<=`, `==`, `!=`
- Logical operators: `&&`, `||`, `!`
- Parentheses for grouping expressions
- Abstract Syntax Tree (AST) generation and display
- Boolean expression evaluation
- Rejection of invalid expressions

## Requirements

- GCC compiler
- Flex
- Bison
- Linux or Ubuntu/WSL terminal

## Project Files

- `lexer.l` — lexical analyzer rules
- `parser.y` — grammar, parser rules, AST construction, and evaluation
- `lex.yy.c` — generated lexer source
- `parser.tab.c` — generated parser source
- `parser.tab.h` — generated parser header
- `boolean_compiler` — compiled executable

## Build Instructions

Open a terminal in the project directory and run:

```bash
bison -d parser.y
flex lexer.l
gcc lex.yy.c parser.tab.c -o boolean_compiler
```

## Run the Compiler

```bash
./boolean_compiler
```

Enter one Boolean expression when prompted.

## Example

Input:

```text
5 > 3 && 8 < 10
```

Expected result:

```text
Valid Boolean expression!
Abstract Syntax Tree:
&&
|-- >
|   |-- 5
|   `-- 3
`-- <
    |-- 8
    `-- 10

Result: TRUE
```

## Invalid Expression Example

Input:

```text
5 > && 3
```

Expected message:

```text
Invalid Boolean expression!
```

## Grammar and Precedence

The grammar is implemented in `parser.y`. The transformed grammar separates expressions into precedence levels so that logical AND has higher precedence than logical OR. Logical NOT is handled recursively at the unary level.

## Limitations

- Numeric comparisons use integer operands.
- Arithmetic expressions such as `5 + 3 > 7` are not supported.
- The compiler processes one expression per execution.

## Conclusion

This project demonstrates the basic stages of a compiler front-end: lexical analysis, syntax analysis, AST construction, and semantic evaluation of Boolean expressions.
