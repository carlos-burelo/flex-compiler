#define IDLEN 31
#define SYMSIZE 100

#define FOR_CONDITION(start, end, step) ((step < 0) ? (start > end) : (start < end))

#define SET 0
#define GET 1

typedef enum
{
    typeCon,
    typeId,
    typeOpr
} nodeEnum;

typedef enum
{
    typeNum,
    typeStr
} conEnum;

typedef struct
{
    conEnum type;
    union
    {
        double dValue;
        char *sValue;
    };

} conNodeType;

typedef struct
{
    int i;
} idNodeType;

typedef struct
{
    int oper;
    int nops;
    struct nodeTypeTag **op;
} oprNodeType;

typedef struct nodeTypeTag
{
    nodeEnum type;
    union
    {
        conNodeType con;
        idNodeType id;
        oprNodeType opr;
    };
} nodeType;
