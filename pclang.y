%{
#include <cstdio>
#include <iostream>

using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern int line_num;

void yyerror(const char *s);

#define YYDEBUG 1

%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int i_val;
	float fval;
	char *s_val;
}

// define the constant-string tokens:
%token T_PROGRAM
%token T_EQUAL
%token T_IS_NOT
%token T_NOT_EQUAL
%token T_BOOL_AND
%token T_BOOL_OR
%token T_OPEN_PARAN
%token T_CLOSE_PARAM
%token T_OPEN_CURLY
%token T_CLOSE_CURLY
%token T_OPEN_SQUARE
%token T_CLOSE_SQUARE
%token T_MUL
%token T_ADD
%token T_SUB
%token T_DIV
%token T_MOD
%token T_GREATER
%token T_GREATER_OR_EQUAL
%token T_LESS
%token T_LESS_OR_EQUAL
%token T_ASSIGN
%token T_SEMICOLON
%token T_COMMA
%token T_DECLARE
%token T_CONST
%token T_AS
%token T_READ
%token T_WRITE
%token T_WHILE
%token T_IF
%token T_ELSE
%token T_CHAR
%token T_INT

%token T_ID

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <i_val> T_CONST_INT
%token <s_val> T_CONST_STR

%%
// the first rule defined is the highest-level rule, which
// is the whole program source code
program_def: prog_heading declarations main_block
    ;
prog_heading: T_PROGRAM T_ID T_SEMICOLON
    ;

declarations:
    | decl T_SEMICOLON
    | declarations decl T_SEMICOLON
    ;

decl: T_DECLARE id_list T_AS type
    | T_CONST T_ID '=' constant
    ;

constant: T_CONST_INT
    | T_CONST_STR
    ;

id_list: T_ID
    | T_ID ',' id_list

main_block: compound_stmt
    ;

compound_stmt: '{' stmt_seq '}'
    ;
stmt_seq:
    | stmt
    | stmt_seq stmt
    ;

stmt: simple_stmt T_SEMICOLON
    | structured_stmt
    ;

simple_stmt: assign_stmt
    | io_stmt
    ;

structured_stmt: if_stmt
    | while_stmt
    ;

assign_stmt: variable '=' expression
    ;

io_stmt: T_READ '(' variable ')'
    | T_WRITE '(' variable ')'
    ;

if_stmt: T_IF '(' condition ')' stmt
    ;

while_stmt: T_WHILE '(' bool_expression ')' stmt
    ;

bool_expression: condition
    | '(' bool_expression ')' bool_operator '(' bool_expression ')'
    ;

bool_operator:  T_IS_NOT
    | T_BOOL_AND
    | T_BOOL_OR
    ;

condition: expression relational_operator expression
    ;

expression: term
    | term arit_operator term
    ;

term: variable
    | T_CONST_INT
    | '(' expression ')'
    ;

relational_operator: T_EQUAL
    | T_NOT_EQUAL
    | T_LESS
    | T_LESS_OR_EQUAL
    | T_GREATER
    | T_GREATER_OR_EQUAL
    ;

arit_operator: T_ADD
    | T_SUB
    | T_MUL
    | T_DIV
    | T_MOD
    ;

variable: T_ID
    | T_ID index_part
    ;

index_part: '[' expression ']'
    | '[' expression ']' index_part
    ;

type: array_type
    | scalar_type
    ;

scalar_type: T_INT
    | T_CHAR
    ;

array_type: scalar_type array_dimensions
    ;


array_dimensions: '[' ']'
    | array_single_dimension
    | array_single_dimension array_single_dimension
    | array_single_dimension array_single_dimension array_single_dimension
    ;

array_single_dimension: '[' T_CONST_INT ']'
    ;
%%

int main(int, char**) {
    printf("Debug is %d\n", YYDEBUG);
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));

}

void yyerror(const char *s) {
	cout << "EEK, parse error on line " << line_num << "!  Message: " << s << endl;
	// might as well halt now:
	exit(-1);
}