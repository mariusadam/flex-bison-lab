%{
#include "pclang.tab.h"

#define YY_DECL extern "C" int yylex()

int line_num = 1;
%}

%%
[ \t\r]          ;
#.*\n   { ++line_num; } // skip line comments
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
";"       { return T_SEMICOLON; }
"=="       { return T_EQUAL; }
"!"       { return T_IS_NOT; }
"!="       { return T_NOT_EQUAL; }
"&&"       { return T_BOOL_AND; }
"||"       { return T_BOOL_OR; }
"("       { return T_OPEN_PARAN; }
")"       { return T_CLOSE_PARAN; }
"{"       { return T_OPEN_CURLY; }
"}"       { return T_CLOSE_CURLY; }
"["       { return T_OPEN_SQUARE; }
"]"       { return T_CLOSE_SQUARE; }
"*"       { return T_MUL; }
"+"       { return T_ADD; }
"-"       { return T_SUB; }
"/"       { return T_DIV; }
"%"       { return T_MOD; }
">"       { return T_GREATER; }
">="       { return T_GREATER_OR_EQUAL; }
"<"       { return T_LESS; }
"<="       { return T_LESS_OR_EQUAL; }
"="       { return T_ASSIGN; }
","       { return T_COMMA; }

[_a-zA-Z][_a-zA-Z0-9]{0,100} { return T_ID; }

[0-9]+ { yylval.i_val = atoi(yytext); return T_CONST_INT; }

\"[^\n]*\"   {
	yylval.s_val = strdup(yytext);
	return T_CONST_STR;
}

\n             { ++line_num;}
%%