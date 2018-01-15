%{
#include <stdio.h>

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern int line_num;

void yyerror(const char *s);

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
%token T_CLOSE_PARAN
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
%token T_CHAR
%token T_INT

%token T_ID

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <i_val> T_CONST_INT
%token <s_val> T_CONST_STR

%error-verbose

// tried to implement if-else as stated at the following link, but unsuccessfully so far :(
// http://epaperpress.com/lexandyacc/if.html

%%
// the first rule defined is the highest-level rule, which
// is the whole program source code
program_def: prog_heading declarations main_block
    ;
prog_heading: T_PROGRAM T_ID T_SEMICOLON
    ;

declarations: decl T_SEMICOLON
    | declarations decl T_SEMICOLON
    ;

decl: T_DECLARE id_list T_AS type
    | T_CONST T_ID T_ASSIGN constant
    ;

constant: T_CONST_INT
    | T_CONST_STR
    ;

id_list: T_ID
    | T_ID T_COMMA id_list

main_block: compound_stmt
    ;

compound_stmt: T_OPEN_CURLY stmt_seq T_CLOSE_CURLY
    ;
stmt_seq: stmt
    | stmt_seq stmt
    ;

stmt: simple_stmt T_SEMICOLON
    | structured_stmt
    | compound_stmt
    ;

simple_stmt: assign_stmt
    | io_stmt
    ;

structured_stmt: if_stmt
    | while_stmt
    ;

assign_stmt: variable T_ASSIGN assign_rhs
    ;

assign_rhs: expression
    | T_CONST_STR
    ;

io_stmt: T_READ T_OPEN_PARAN variable T_CLOSE_PARAN
    | T_WRITE T_OPEN_PARAN assign_rhs T_CLOSE_PARAN
    ;

if_stmt: T_IF T_OPEN_PARAN condition T_CLOSE_PARAN stmt
    ;

while_stmt: T_WHILE T_OPEN_PARAN bool_expression T_CLOSE_PARAN stmt
    ;

bool_expression: condition
    | T_OPEN_PARAN bool_expression T_CLOSE_PARAN bool_operator T_OPEN_PARAN bool_expression T_CLOSE_PARAN
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
    | T_OPEN_PARAN expression T_CLOSE_PARAN
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

index_part: T_OPEN_SQUARE expression T_CLOSE_SQUARE
    | T_OPEN_SQUARE expression T_CLOSE_SQUARE index_part
    ;

type: array_type
    | scalar_type
    ;

scalar_type: T_INT
    | T_CHAR
    ;

array_type: scalar_type array_dimensions
    ;


array_dimensions: T_OPEN_SQUARE T_CLOSE_SQUARE
    | array_single_dimension
    | array_single_dimension array_single_dimension
    | array_single_dimension array_single_dimension array_single_dimension
    ;

array_single_dimension: T_OPEN_SQUARE T_CONST_INT T_CLOSE_SQUARE
    ;
%%

int main(int, char**) {
    printf("Debug is %d\n", YYDEBUG);
    yydebug = 1;
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));

}

void yyerror(const char *s) {
	printf("Parse error on line %d!  Message: %s\n", line_num, s);
	// might as well halt now:
	exit(-1);
}