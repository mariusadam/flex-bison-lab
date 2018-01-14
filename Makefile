.DEFAULT_GOAL := pclang

pclang.tab.c pclang.tab.h: pclang.y
	bison -t -v -d -b out/pclang pclang.y

lex.yy.c: pclang.l pclang.tab.h
	flex -o out/lex.yy.c pclang.l

pclang: lex.yy.c pclang.tab.c pclang.tab.h
	g++ out/pclang.tab.c out/lex.yy.c -lfl -o out/pclang