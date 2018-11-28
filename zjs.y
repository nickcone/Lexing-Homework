%{
	#include <stdio.h>
	#include "zjs.h"
	int yylex();
	int yyerror(const char* err);
%}

%union {int iVal; float fVal;}
%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%type<iVal> INT
%type<fVal> FLOAT

%%

program:	list_of_expr END
	;

list_of_expr:	expr
	|	expr list_of_expr 
	;
expr:		command END_STATEMENT
	;

command:	line
    |  		point
    |  		circle
    |		rectangle
    |		set_color
    ;

line: LINE INT INT INT INT {
	if ($2 < 0 || $2 > WIDTH){
		printf("LINE ERROR:x1 must be between 0-%d\n", WIDTH);
	}
	else if ($3 < 0 || $3 > HEIGHT){
		printf("LINE ERROR:y1 must be between 0-%d\n", HEIGHT);
	}
	else if ($4 < 0 || $4 > WIDTH){
		printf("LINE ERROR:x2 must be between 0-%d\n", WIDTH);
	}
	else if ($5 < 0 || $5 > HEIGHT){
		printf("LINE ERROR:y2 must be between 0-%d\n", HEIGHT);
	}
	else {
		line($2, $3, $4, $5);
	}
};
point: POINT INT INT {
	if ($2 < 0 || $2 > WIDTH){
		printf("POINT ERROR:x must be between 0-%d\n", WIDTH);
	}
	else if ($3 < 0 || $3 > HEIGHT){
		printf("POINT ERROR:y must be between 0-%d\n", HEIGHT);
	}
	else {
		point($2, $3);
	}
};
circle: CIRCLE INT INT INT {

	if ($2 < 0 || $2 > WIDTH){
		printf("CIRCLE ERROR:x must be between 0-%d\n", WIDTH);
	}
	else if ($3 < 0 || $3 > HEIGHT){
		printf("CIRCLE ERROR:y must be between 0-%d\n", HEIGHT);
	}
	else if ($4 < 0) {
		printf("CIRCLE ERROR:radius must be greater than 0 and positive\n");
	}
	else {
		circle($2, $3, $4);
	}
};
rectangle: RECTANGLE INT INT INT INT {

	if ($2 < 0 || $2 > WIDTH){
		printf("RECTANGLE ERROR:x must be between 0-%d\n", WIDTH);
	}
	else if ($3 < 0 || $3 > HEIGHT){
		printf("RECTANGLE ERROR:y must be between 0-%d\n", HEIGHT);
	}
	else if ($4 < 0 || $4 > WIDTH - $2){
		printf("RECTANGLE ERROR:width must be between 0-%d\n", WIDTH - $2);
	}
	else if ($5 < 0 || $5 > HEIGHT - $3){
		printf("RECTANGLE ERROR:Height must be between 0-%d\n", HEIGHT - $3);
	}
	else {
		rectangle($2, $3, $4, $5);
	}

};
set_color: SET_COLOR INT INT INT {

	if ($2 < 0 || $2 > 255) {
		printf("SET_COLOR ERROR:1st parameter must be between 0-255\n");
	}
	else if ($3 < 0 || $3 > 255) {
		printf("SET_COLOR ERROR:2nd parameter must be between 0-255\n");
	}
	else if ($4 < 0 || $4 > 255) {
		printf("SET_COLOR ERROR:3rd parameter must be between 0-255\n");
	}
	else {
		set_color($2, $3, $4);
	}
};

%%

int main(int argc, char** argv){
	setup();
	yyparse();
}

int yyerror(const char* err){
	printf("%s\n", err);
}
