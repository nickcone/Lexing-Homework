%{
#include <stdio.h>
int lineNum=0;
%}

%%

END {printf("\nEXIT INTERPRETER\n");}
; {printf("\nEND STATEMENT");}
POINT {printf("POINT\n");}
LINE {printf("LINE\n");}
CIRCLE {printf("CIRCLE\n");}
RECTANGLE {printf("RECTANGLE\n");}
SET_COLOR {printf("SET COLOR\n");}
[0-9]+\.[0-9]* {printf("FLOAT");}
[0-9]+[^0-9] {printf("INTEGER\n");}
[ \t] 
[\n] {lineNum++;}
. {printf("\nError:User messed up on Line: "); printf("%d",lineNum); return 1;}

%%
int main(int argc, char** argv){
	yylex();
	return 0;
}

