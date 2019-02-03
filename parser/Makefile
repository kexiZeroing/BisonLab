# Makefile

CC = gcc

demo: myparser.tab.c myparser.tab.h lex.yy.c main.c
	$(CC) -o demo myparser.tab.c lex.yy.c main.c 

myparser.tab.c myparser.tab.h: myparser.y
	bison -vd myparser.y

lex.yy.c: myscanner.l myparser.tab.h
	flex myscanner.l

clean:
	rm demo myparser.tab.c myparser.tab.h lex.yy.c