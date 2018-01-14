%{
#include <iostream>
#include "pclang.tab.h"

using namespace std;

#define YY_DECL extern "C" int yylex()

int line_num = 1;
%}

%%
[ \t]          ;
program { return T_PROGRAM; }
const   { return T_CONST; }
declare { return T_DECLARE; }
as      { return T_AS; }
read    { return T_READ; }
write   { return T_WRITE; }
while   { return T_WHILE; }
if      { return T_IF; }
char    { return T_CHAR; }
int     { return T_INT; }

([_a-zA-Z])[_a-zA-Z0-9]* { return T_ID; }

[1-9][0-9]+ { yylval.i_val = atoi(yytext); return T_CONST_INT; }

"[a-zA-Z0-9]*"   {
	yylval.s_val = strdup(yytext);
	return T_CONST_STR;
}

\n             { ++line_num;}
.              ;
%%