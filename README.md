# Boolean Expression Compiler

## 1. Overview

The Boolean Expression Compiler is a mini compiler project developed using C, Flex, and Bison. It accepts Boolean expressions, performs lexical and syntax analysis, constructs an Abstract Syntax Tree (AST), and evaluates the expression to produce a Boolean result.

## 2. Features

- Lexical analysis using Flex
- Syntax analysis using Bison
- Boolean constants: `true`, `false`
- Relational operators: `>`, `<`, `>=`, `<=`, `==`, `!=`
- Logical operators: `&&`, `||`, `!`
- Parentheses for grouping expressions
- Abstract Syntax Tree (AST) construction and display
- Boolean expression evaluation
- Detection of invalid syntax

## 3. Technologies and Requirements

- C programming language
- GCC compiler
- Flex
- Bison
- Linux or Ubuntu/WSL terminal
- GNU Make

## 4. Project Structure

| File | Purpose |
|---|---|
| `lexer.l` | Defines lexical analysis rules |
| `parser.y` | Defines grammar rules and syntax analysis |
| `ast.h` | Declares the AST node structure and AST functions |
| `ast.c` | Creates and prints the Abstract Syntax Tree |
| `semantic.h` | Declares the expression evaluation function |
| `semantic.c` | Evaluates the AST and calculates the Boolean result |
| `main.c` | Contains the program entry point |
| `Makefile` | Automates the build process |
| `README.md` | Project documentation |

The files `lex.yy.c`, `parser.tab.c`, and `parser.tab.h` are generated automatically by Flex and Bison during compilation. They do not need to be edited manually.

## 5. Build Instructions

Install GCC, Flex, Bison, and Make if they are not already installed. From the project directory, run:

```bash
make
```

To remove generated files and the executable:

```bash
make clean
```

## 6. Run the Compiler

```bash
./boolean_compiler
```

Enter a Boolean expression when prompted.

## 7. Example

**Input:**

```text
5 > 3 && 8 < 10
```

**Expected output:**

```text
Enter a Boolean expression:

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

## 8. Invalid Expression Example

**Input:**

```text
5 > && 3
```

The compiler reports:

```text
Invalid Boolean expression!
```

## 9. Grammar and Operator Precedence

The grammar is defined in `parser.y`. It separates expressions into different levels to establish operator precedence:

1. Parenthesized expressions, constants, and comparisons
2. Logical NOT (`!`)
3. Logical AND (`&&`)
4. Logical OR (`||`)

Logical AND has higher precedence than logical OR. Parentheses can be used to group expressions and control evaluation order.

## 10. Limitations

- Relational comparisons accept integer operands.
- Arithmetic expressions such as `5 + 3 > 7` are not supported.
- Variables and variable assignments are not supported.
- The compiler processes one expression per execution.
- Semantic evaluation is implemented through AST evaluation; a separate comprehensive type-checking system is not included.

## 11. Individual Contributions

Team Members & Individual Contributions
Sabari A S (Team Lead)

Role: Implemented lexical analysis rules in lexer.l.

Documentation: Co-authored the project report.

Sera Liz David

Role: Developed the program entry point and execution flow in main.c.

Documentation: Co-authored the project report.

Niya Tom

Role: Designed the AST node structure and tree-display logic in ast.c and ast.h.

Documentation: Co-authored the project report.

S Devadathan

Role: Created the Makefile build script and README.md documentation.

Documentation: Co-authored the project presentation slides.

Rohith Samuel

Role: Implemented AST semantic evaluation and boolean calculations in semantic.c and semantic.h.

Documentation: Co-authored the project presentation slides.

Parvathy Prakash

Role: Defined the Context-Free Grammar (CFG) rules and operator precedence in parser.y.

Documentation: Co-authored the project presentation slides

## 12. Conclusion

This project demonstrates key compiler front-end concepts: lexical analysis, syntax analysis, grammar-based parsing, AST construction, and semantic evaluation of Boolean expressions.
