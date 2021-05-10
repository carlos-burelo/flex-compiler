<img src="https://user-images.githubusercontent.com/52249052/117655651-2d2e3080-b1b9-11eb-803f-f1210c0131e6.png" width=70 />

## *Chicken Programming Language*
A simple, light programming language for basic calculation and problem solving.

<br/>

#### *Commands to create compiler `chick.exe`*
```
bison -d chicken.y
flex chicken.l
gcc -o chick lex.yy.c chicken.tab.c
```
<br/>

#### *Run program*
1. ***Interactive mode*** command is `chick`.
2. ***To run a script***, command is `chick <file-name>.txt`.<br/>For example, `chick sample-programs/7_prime_numbers.txt`.

<br/>

#### *Table of content*
| Topic | Description |
| :---: | --- |
| Data types | `Numbers`: Default data type. Similar to C double data type.<br/>`String`: Similar to C character array. |
| Variables initialization | All variables are initialized globally.<br/>***variablename := expression;***<br/><br/>`i := 0;`<br/>`firstVariable =: -21.5;` |
| Comment | Single line comment starts with `#` character.<br/><br/>`# This is a comment` |
| Print statement | Prints expression or string without newline.<br/><br/>***print expression;***<br/>`print 10+20;`<br/>`print firstVariable;`<br/><br/>***print string;***<br/>`print "Hello world\n";` |
| Scan statement | Only works in interactive mode.<br/>***scan variable;***<br/><br/>`scan firstVariable;` |
| Operators | Precedence:<br/><ol><li>***( expression )***<br>`print (10+20)/3;` `Output: 10`</li><br/><li>***not***: Logical NOT<br>`print not 0;` `Output: 1`</li><br/><li>***\**** : Multiplication<br/>`print 2*4;` `Output: 8`<br/><br/>***/*** : Division<br/>`print 4/2;` `Output: 2`<br/><br/>***%*** : Modulus<br/>`print 11%3;` `Output: 2`</li><br/><li>***+*** : Plus<br/>`print 4+2;` `Output: 6`<br/><br/>***-*** : Minus<br/>`print 4-2;` `Output: 2`</li><br/><li>***>=*** : Grater than or equal<br/>`print 11 >= 4.2;` `Output: 1`<br/><br/>***<=*** : Less than or equal<br/>`print 11 <= 11;` `Output: 1`<br/><br/>***=*** : Equal to<br/>`print 4=4;` `Output: 1`<br/><br/>***!=*** : Not equal to<br/>`print 4!=4;` `Output: 0`<br/><br/>***>*** : Grater than<br/>`print 4>2;` `Output: 1`<br/><br/>***<*** : Less than<br/>`print 4<2;` `Output: 0`</li><br/><li>***and*** : Logical AND<br/>`print 1 and 0;` `Output: 0`<br/><br/>***or*** : Logical OR<br/>`print 1 or 0;` `Output: 1`</li></ol> |
| If Else | <ol><li>***if expression then statement***<br/>`if not 0 then print "Hello\n";`</li><br/><li>***if expression then statement***<br/>***else statement***<br/><br/>`if 0 then print "Zero\n";`<br/>`else print "Not zero";`</li><br/><li>***if expression then statement***<br/>***else if expression then statement***<br/>***else statement***<br/><br/>`number1 := -10;`<br/>`number2 := -7;`<br/>`if number1 = number2 then print "number1 = number2";`<br/>`else if number1 > number2 then print "number1 > number2";`<br/>`else print "number1 < number2";`<br/></li></ol> |
| While loop | ***while expression then statement***<br/><br/>`i := 0;`<br/>`while i < 10 then {`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`print i;`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`print "\n";`<br/>&nbsp;&nbsp;&nbsp;&nbsp;`i := i + 1;`<br/>`}` |
| Random number | Returns a randomly generated number within lower to upper.<br/>***random(lower, upper)***<br/><br/>`print random(1.21, 3.15);` |
