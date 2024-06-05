%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <stdarg.h>
    #include <string.h>
    #include <time.h>
    #include <math.h>
    #include "v.h"
    #define YYDEBUG 0
    int obtener_indice(char *id, char mode);
    nodeType *id(char *vName, char mode);   
    nodeType *condicion(double dValue);          
    nodeType *constante(char *sValue);           
    nodeType *operacion(int oper, int nops, ...); 
    void nodo_libre(nodeType *p);             
    double expresion(nodeType *p);                 
    int yylex(void);
    void yyerror(char *);
    double sym[SYMSIZE];        
    char vars[SYMSIZE][IDLEN];  
    unsigned int seed;
%}

%union {
    double dValue;
    char *sValue;
    char *vName;
    nodeType *nPtr;
}

%token <dValue> NUMBER
%token <vName> VARIABLE
%token <sValue> STRING
%token WHILE FOR IF THEN PRINT ASSIGN EXIT RANDOM PI SCAN LOG EXP SQRT FLOOR CEIL ABS SIN ASIN COS ACOS TAN ATAN
%nonassoc IFX
%nonassoc ELSE

%left AND OR
%left GE LE '=' NE '>' '<'
%left '+' '-'
%left '*' '/' '%'
%left NOT
%left '^'
%nonassoc UMINUS

%type <nPtr> statement expression statement_list

%%
program : function { exit(0); }
        ;

function : 
         | function statement { expresion($2); nodo_libre($2); }
         ;

statement : ';' { $$ = operacion(';', 2, NULL, NULL); }
          | expression ';' { $$ = $1; }
          | EXIT ';' { exit(0); }
          | VARIABLE ASSIGN expression ';' { $$ = operacion(ASSIGN, 2, id($1, SET), $3); }
          | PRINT expression ';' { $$ = operacion(PRINT, 1, $2); }
          | PRINT STRING ';' { $$ = operacion(PRINT, 1, constante($2)); }
          | SCAN VARIABLE ';' { $$ = operacion(SCAN, 1, id($2, GET)); }
          | WHILE expression THEN statement { $$ = operacion(WHILE, 2, $2, $4); }
          | FOR VARIABLE ':' '(' expression ',' expression ',' expression ')' THEN statement { $$ = operacion(FOR, 5, id($2, GET), $5, $7, $9, $12); }
          | IF expression THEN statement %prec IFX { $$ = operacion(IF, 2, $2, $4); }
          | IF expression THEN statement ELSE statement { $$ = operacion(IF, 3, $2, $4, $6); }
          | '{' statement_list '}' { $$ = $2; }
          ;

statement_list : statement { $$ = $1; }
               | statement_list statement { $$ = operacion(';', 2, $1, $2); }
               ;

expression : NUMBER { $$ = condicion($1); }
           | VARIABLE { $$ = id($1, GET); }
           | PI { $$ = operacion(PI, 0); }
           | RANDOM '(' expression ',' expression ')' { $$ = operacion(RANDOM, 2, $3, $5); }
           | LOG '(' expression ')' { $$ = operacion(LOG, 1, $3); }
           | LOG '(' expression ',' expression ')' { $$ = operacion(LOG, 2, $3, $5); }
           | EXP '(' expression ')' { $$ = operacion(EXP, 1, $3); }
           | SQRT '(' expression ')' { $$ = operacion(SQRT, 1, $3); }
           | FLOOR '(' expression ')' { $$ = operacion(FLOOR, 1, $3); }
           | CEIL '(' expression ')' { $$ = operacion(CEIL, 1, $3); }
           | ABS '(' expression ')' { $$ = operacion(ABS, 1, $3); }
           | SIN '(' expression ')' { $$ = operacion(SIN, 1, $3); }
           | ASIN '(' expression ')' { $$ = operacion(ASIN, 1, $3); }
           | COS '(' expression ')' { $$ = operacion(COS, 1, $3); }
           | ACOS '(' expression ')' { $$ = operacion(ACOS, 1, $3); }
           | TAN '(' expression ')' { $$ = operacion(TAN, 1, $3); }
           | ATAN '(' expression ')' { $$ = operacion(ATAN, 1, $3); }
           | '-' expression %prec UMINUS { $$ = operacion(UMINUS, 1, $2); }
           | expression '^' expression { $$ = operacion('^', 2, $1, $3); }
           | expression '+' expression { $$ = operacion('+', 2, $1, $3); }
           | expression '-' expression { $$ = operacion('-', 2, $1, $3); }
           | expression '*' expression { $$ = operacion('*', 2, $1, $3); }
           | expression '/' expression { $$ = operacion('/', 2, $1, $3); }
           | expression '%' expression { $$ = operacion('%', 2, $1, $3); }
           | expression '<' expression { $$ = operacion('<', 2, $1, $3); }
           | expression '>' expression { $$ = operacion('>', 2, $1, $3); }
           | expression GE expression { $$ = operacion(GE, 2, $1, $3); }
           | expression LE expression { $$ = operacion(LE, 2, $1, $3); }
           | expression '=' expression { $$ = operacion('=', 2, $1, $3); }
           | expression NE expression { $$ = operacion(NE, 2, $1, $3); }
           | expression AND expression { $$ = operacion(AND, 2, $1, $3); }
           | expression OR expression { $$ = operacion(OR, 2, $1, $3); }
           | NOT expression { $$ = operacion(NOT, 1, $2); }
           | '(' expression ')' { $$ = $2; }
           ;
%%

int obtener_indice(char *id, char mode){
    
    switch (mode) {
        case GET:       
        {
            for (int i = 0; i < SYMSIZE; i++) {
                if (!strcmp(vars[i], "-1")) return -1;
                else if (!strcmp(id, vars[i])) return i;    
            }
            return -1;
        }
        case SET:       
        {
            for (int i = 0; i < SYMSIZE; i++) {
                if (!strcmp(id, vars[i])) return i;     
                else if (!strcmp(vars[i], "-1")) {
                    strcpy(vars[i], id);
                    return i;
                }
            }
            return -1;
        }
    }
}

nodeType *id(char *vName, char mode) {
    int sIndex = obtener_indice(vName, mode);
    if (sIndex == -1 && mode == GET) {
        yyerror("variable not initialized");
        exit(1);
    }
    else if (sIndex == -1 && mode == SET) {
        yyerror("failed to initialize variable");
        exit(1);
    }

    nodeType *p;
     
    
    if ((p = malloc(sizeof(nodeType))) == NULL)
        yyerror("out of memory");

    
    p->type = typeId;
    p->id.i = sIndex;

    return p;
}

nodeType *condicion(double dValue) {
    nodeType *p;
     
    
    if ((p = malloc(sizeof(nodeType))) == NULL)
        yyerror("out of memory");

    
    p->type = typeCon;
    p->con.type = typeNum;
    p->con.dValue = dValue;

    return p;
}

nodeType *constante(char *sValue) {
    nodeType *p;
     
    
    if ((p = malloc(sizeof(nodeType))) == NULL)
        yyerror("out of memory");

    
    p->type = typeCon;
    p->con.type = typeStr;
    p->con.sValue = strdup(sValue);

    return p;
}

nodeType *operacion(int oper, int nops, ...) {
    va_list ap;
    nodeType *p;
     
    
    if ((p = malloc(sizeof(nodeType))) == NULL)
        yyerror("out of memory");
    if ((p->opr.op = malloc(nops * sizeof(nodeType *))) == NULL)
        yyerror("out of memory");

    
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    
    va_start(ap, nops);
    for (int i = 0; i < nops; i++) 
        p->opr.op[i] = va_arg(ap, nodeType *);
    va_end(ap);

    return p;
}

void nodo_libre(nodeType *p) {
    if (!p) return;
    if (p->type == typeOpr) {
        for (int i = 0; i < p->opr.nops; i++)
            nodo_libre(p->opr.op[i]);
        free(p->opr.op);
    }
    free(p);
}

double expresion(nodeType *p) {
    if (!p) return 0;

    switch (p->type) {
        case typeCon: return p->con.dValue;
        case typeId: return sym[p->id.i];
        case typeOpr:
            switch (p->opr.oper) {
                case WHILE:
                    while (expresion(p->opr.op[0]))
                        expresion(p->opr.op[1]);
                    return 0;
                case FOR:
                {                    
                    sym[p->opr.op[0]->id.i] = expresion(p->opr.op[1]);     
                    double end = expresion(p->opr.op[2]), step = expresion(p->opr.op[3]);
                    while (FOR_CONDITION(sym[p->opr.op[0]->id.i], end, step)) {
                        expresion(p->opr.op[4]);
                        sym[p->opr.op[0]->id.i] += step;
                    }
                    return 0;
                }
                case IF:
                    if (expresion(p->opr.op[0]))
                        expresion(p->opr.op[1]);
                    else if (p->opr.nops > 2)
                        expresion(p->opr.op[2]);
                    return 0;
                case PRINT:
                    if (p->opr.op[0]->type == typeCon && p->opr.op[0]->con.type == typeStr) {
                        char *sValue = p->opr.op[0]->con.sValue;
                        int i, slen = strlen(sValue);
                        for (i = 0; i < slen-1; i++) {
                            if (sValue[i] == '\\' && sValue[i+1] == 'n') {
                                printf("\n");
                                i++;
                            }
                            else if (sValue[i] == '\\' && sValue[i+1] == 't') {
                                printf("\t");
                                i++;
                            }
                            else printf("%c", sValue[i]);
                        }
                        if (i == slen-1) printf("%c", sValue[i]);
                        return 0;
                    }
                    else {
                        double dValue = expresion(p->opr.op[0]);
                        if (dValue == floor(dValue)) printf("%d", (int)dValue);
                        else if (dValue - floor(dValue) < 1e-6) printf("%e", dValue);
                        else printf("%lf", dValue);
                        return 0;
                    }
                case SCAN:
                {
                    double dValue;
                    printf(">>> ");
                    scanf("%lf", &dValue);
                    return sym[p->opr.op[0]->id.i] = dValue;
                }
                case RANDOM:
                {
                    double lower = expresion(p->opr.op[0]), upper = expresion(p->opr.op[1]);
                    srand(seed += 912);
                    if (upper - lower < 1)
                        return ((double)rand() * (upper - lower)) / (double)RAND_MAX + lower;
                    else 
                        return ((double)rand() / RAND_MAX) + (rand() % ((int)upper - (int)lower)) + lower;
                }
                case LOG:
                {
                    if (p->opr.nops == 1) return log(expresion(p->opr.op[0]));
                    else return log(expresion(p->opr.op[0])) / log(expresion(p->opr.op[1]));
                }
                case EXP:
                {
                    return exp(expresion(p->opr.op[0]));
                }
                case SQRT:
                {
                    return sqrt(expresion(p->opr.op[0]));
                }
                case FLOOR: return floor(expresion(p->opr.op[0]));
                case CEIL: return ceil(expresion(p->opr.op[0]));
                case ABS: return fabs(expresion(p->opr.op[0]));
                case PI: return M_PI;
                case SIN: return sin(expresion(p->opr.op[0]));
                case ASIN: return asin(expresion(p->opr.op[0]));
                case COS: return cos(expresion(p->opr.op[0]));
                case ACOS: return acos(expresion(p->opr.op[0]));
                case TAN: return tan(expresion(p->opr.op[0]));
                case ATAN: return atan(expresion(p->opr.op[0]));
                case ';':
                    expresion(p->opr.op[0]);
                    return expresion(p->opr.op[1]);
                case ASSIGN: return sym[p->opr.op[0]->id.i] = expresion(p->opr.op[1]);
                case UMINUS: return -expresion(p->opr.op[0]);
                case '^': return pow(expresion(p->opr.op[0]), expresion(p->opr.op[1]));
                case '+': return expresion(p->opr.op[0]) + expresion(p->opr.op[1]);
                case '-': return expresion(p->opr.op[0]) - expresion(p->opr.op[1]);
                case '*': return expresion(p->opr.op[0]) * expresion(p->opr.op[1]);
                case '/': return expresion(p->opr.op[0]) / expresion(p->opr.op[1]);
                case '%': return (int)expresion(p->opr.op[0]) % (int)expresion(p->opr.op[1]);
                case '>': return expresion(p->opr.op[0]) > expresion(p->opr.op[1]);
                case '<': return expresion(p->opr.op[0]) < expresion(p->opr.op[1]);
                case GE: return expresion(p->opr.op[0]) >= expresion(p->opr.op[1]);
                case LE: return expresion(p->opr.op[0]) <= expresion(p->opr.op[1]);
                case '=': return expresion(p->opr.op[0]) == expresion(p->opr.op[1]);
                case NE: return expresion(p->opr.op[0]) != expresion(p->opr.op[1]);
                case AND: return (int)expresion(p->opr.op[0]) && (int)expresion(p->opr.op[1]);
                case OR: return (int)expresion(p->opr.op[0]) || (int)expresion(p->opr.op[1]);
                case NOT: return !(int)expresion(p->opr.op[0]);
            }
    }
    return 0;
}

int main(int argc, char **argv) {
    #if YYDEBUG
        yydebug = 1;
    #endif

    seed = time(NULL);

    
    for (int i = 0; i < SYMSIZE; i++) strcpy(vars[i], "-1");

    if (argc < 2)
        yyparse();
    else {
        freopen(argv[1], "r", stdin);
        yyparse();
    }

    return 0;
}