%{
    #include <stdlib.h>
    #include <string.h>
    #include "v.h"
    #include "v.tab.h"
    void yyerror(char *s);
    int lineno = 0;
%}

IDENTIFICADOR      [a-zA-Z][a-z0-9A-Z_]*
EXPO    [Ee][-+]?[0-9]+

%%
"#".*

[0-9]+|[0-9]+"."[0-9]*{EXPO}?|"."?[0-9]+{EXPO}? {
    yylval.dValue = atof(yytext);
    return NUMBER;
}

\"[^"\n]*["\n] {
    yylval.sValue = strdup(yytext+1);
    if (yylval.sValue[yyleng-2] != '"')
        yyerror("Cadena no cerrada");
    else {
        yylval.sValue[yyleng-2] = 0;
        return STRING;
    }
}

[-()<>=+*/%^,;:{}] {
    return *yytext;
}

">="    return GE;
"<="    return LE;
"!="    return NE;
":="    return ASSIGN;
"while" return WHILE;
"for"   return FOR;
"si"    return IF;
"else"  return ELSE;
"entonces"  return THEN;
"y"   return AND;
"o"    return OR;
"no"   return NOT;

"imprimir" return PRINT;
"scan"  return SCAN;
"salir"  return EXIT;

"PI"    return PI;

"random"    return RANDOM;
"log"       return LOG;
"exp"       return EXP;
"sqrt"      return SQRT;
"floor"     return FLOOR;
"ceil"      return CEIL;
"abs"       return ABS;
"sin"       return SIN;
"asin"      return ASIN;
"cos"       return COS;
"acos"      return ACOS;
"tan"       return TAN;
"atan"      return ATAN;

{IDENTIFICADOR} {
    yylval.vName = strdup(yytext);
    return VARIABLE;
}

[ \t]

\n { ++lineno; }

. {
    yyerror("Unknown character");
    exit(1);
}
%%

int yywrap(void) {
    return 1;
}

void yyerror(char *s) {
    fprintf(stdout, "line %d: %s\n", lineno, s);
}