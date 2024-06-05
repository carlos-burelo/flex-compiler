@echo off

if not exist build mkdir build

cd src

bison -d v.y
flex v.l
gcc -o v lex.yy.c v.tab.c

move v.tab.h ..\build > nul
move v.tab.c ..\build > nul
move lex.yy.c ..\build > nul
move v.exe ..\build > nul

cd ..

:: ejecutamos todos los txt de la carpeta 'ejemplos' con un separador

for %%f in (ejemplos\*.txt) do (
    echo ------------------------------------------------
    echo Ejecutando %%f
    echo ------------------------------------------------
    build\v < %%f
    echo.
    echo.
)

