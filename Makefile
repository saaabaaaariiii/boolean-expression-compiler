
CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -Wall -Wextra -std=gnu11

TARGET = boolean_compiler

all: $(TARGET)

parser.tab.c parser.tab.h: parser.y ast.h semantic.h
	$(BISON) -d parser.y

lex.yy.c: lexer.l parser.tab.h
	$(FLEX) lexer.l

$(TARGET): lex.yy.c parser.tab.c ast.c semantic.c main.c
	$(CC) $(CFLAGS) lex.yy.c parser.tab.c ast.c semantic.c main.c -o $(TARGET)

clean:
	rm -f $(TARGET) lex.yy.c parser.tab.c parser.tab.h

.PHONY: all clean

