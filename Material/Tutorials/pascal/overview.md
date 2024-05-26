# Pascal - Overview

---

## introduction

* designed: 1968 by Niklaus Wirth
* published: 1970
* imperative, structural, procedural
* static and strong typing
* designed to be simple
* we will use FreePascal

---

## a basic program

```pascal
program HelloWorld;
{ Definitions are placed here - 
  types, variables, procedures, functions, ...}
begin
    WriteLn('Hello, World!')
    { More statements can be added here }
end.
```

---

## built-in data types

* `integer`
* `boolean`
* `real`
* `char`
* `string`

---

## variables

> `var` **\<name\>** `:` **\<type\>**

* must be declared in the definitions section
* assign values using walrus operator (:=)

<!--vert-->

### variables usage example

```pascal
program HelloWorld;
var str : string;
begin
    str := 'Hello, World!';
    WriteLn(str) // no semicolon
end.
```

<!--vert-->

### multiple variables declaration

```pascal
var s1, s2 : string;

var c1 : char;
    b1 : boolean;
```

---

## comments

* multiline
  * `{ ... }`
  * `{* ... *}`
  * `(* ... *)`
* single line
  * `// ...`

---

## input & output

* `Write(1, 2, 'hello');`
* `WriteLn(x, y);`
* `Read(x);`
* `ReadLn(y);`

---

## enumerated types

```pascal
type Color = (Red, Green, Blue, Yellow);
```

enumerated types are ordered

```pascal
Red < Blue = true;
ord(Yellow) = 3;
succ(Red) = Green;
pred(Blue) = Green
```

---

## subrange types

```pascal
type Letter = 'A' .. 'Z';
     Idx = 3 .. 8;
     BasicColor = Red .. Blue;
```

* important note - boundaries are not enforced

---

## set types
> `type` **\<name\>** `=` `set` `of` **\<range type\>**

for example:

```pascal
type Rainbow = set of Color;
```

sets have many many functions to work with - union, intersection, etc.

<!--vert-->

### union

consider these two sets:

```pascal
var s1, s2 : Rainbow;
begin
     s1 := [Red, Green];
     s2 := [Green, Blue, Yellow]
end.
```

the result set contains all elements of `s1` and `s2`:

```pascal
s1 + s2 = [Red, Green, Blue, Yellow]
```

<!--vert-->

### intersection

```pascal
var s1, s2 : Rainbow;
begin
     s1 := [Red, Green];
     s2 := [Green, Blue, Yellow]
end.
```

the result set contains all elements of `s1` that also belong to `s2`:

```pascal
s1 * s2 = [Green]
```

<!--vert-->

### symmetric difference

```pascal
var s1, s2 : Rainbow;
begin
     s1 := [Red, Green];
     s2 := [Green, Blue, Yellow]
end.
```

the result set contains all elements of `s1` and `s2` that belong **only** to one of them:

```pascal
s1 >< s2 = [Red, Blue, Yellow]
```

<!--vert-->

### operator in

```pascal
var s1, s2 : Rainbow;
begin
     s1 := [Red, Green];
     s2 := [Green, Blue, Yellow]
end.
```

checks membership of an element in a set

```pascal
Red in s1; { true }
Red in s2; { false }
```

---

## arithmetic operators
* `+`
* `-`
* `*`
* `/`
* `div` (integer division)
* `mod`
---
## relational operators

* `=` (equals)
* `<>` (not equals)
* `<`
* `<=`
* and so on...
---

## logical operators

* `or`
* `and`
* `not`

---
## control flow - if

```pascal
if x < 2 then write(x);
```

the expression between `if` and `then` must be of type `boolean`

```pascal
if x < 2 then
begin
    write(x)
end;
```

```pascal
if x < 2 then
    write(x) // no semicolon!
else
    write(y);
```

---

## control flow - case

```pascal
case i of
    1: write('A');
    2: write('B');
    3: write('C') // no semicolon!
end
```

---

## control flow - while

```pascal
while x < 5 do
begin
    read(x)
end;
```

---

## control flow - repeat

```pascal
repeat
    read(x)
until x > 5;
```

---

## control flow - for

```pascal
for i := 1 to 10 do
    WriteLn(i);
```

```pascal
for i := 10 downto 1 do
begin
    WriteLn(i)
end;
```

the final value of `i` is undefined

<!--vert-->

*for* supports integers, chars or any enumerated types:

```pascal
for i := 'a' to 'z' do
     WriteLn(i)
```

iterating over all elements in a set:

```pascal
WriteLn('Color set S contains: ');
for c := Red to Yellow do
    if c in S then WriteLn(c)
```

---
## records

```pascal
type date = record
        day: 1 .. 31;
        month: (January, February, March, April, May, June,
                July, August, September, October, November, December);
        year: 1900 .. 2100
     end;
```

to access a field use `.`:

```pascal
today.year
```

<!--vert-->

### variant records

```pascal
type Point = record
        letter: char;
        case UsePolar : boolean of
            False : (X, Y, Z : Real);
            True  : (R, theta, phi : Real)
    end;
```

The `Point` record will have different fields based on the value of `UsePolar`.
<!--vert-->

### variant records usage example

```pascal
if (not p.UsePolar) then
    r := CubicRoot(p.X*p.X + p.Y*p.Y + p.Z*p.Z)
else
    r := p.R
end.

```

---

## Arrays in Pascal

> `array` **index-type** `of` **element-type**

for example:

```pascal
var A: array [1..5] of real;
    pens: array [Red..Green] of
        record
            width: 1..3;
            kind: (Regular, Bold)
        end;
```

<!--vert-->

### arrays usage example
```pascal
var A: array [1..5] of real;
    pens: array [Red..Green] of
        record
            width: 1..3;
            kind: (Regular, Bold)
        end;
```

```pascal
A[2] := 3.14;
pens[Red].width := 2;

```
---

## strings
strings are treated as arrays of characters.
* access a character using `[]`, **using 1-based indexing**
* `Length` is used to get a strings length


<!--vert-->

### strings example

```pascal
var s : string;
    c : char;
    i : integer;
```

```pascal
s := 'Hello, World!';
c := s[1]; { c = 'H' }
i := Length(s); { i = '13' }
s[i] := '?'; { s = 'Hello, World?' }

```


---

## functions

Pascal functions always return a value

```pascal
function myFunc(a: integer; b: real): real;
begin
    myFunc := a * b // that's how you set the return value
end;
```

* in this example `a` and `b` are passed by-value

---

## procedures

a function that doesn't return anything is a procedure

```pascal
procedure myProc(var a: boolean);
begin
    WriteLn('Hello, World!');
    a := true
end;
```

`var` here means "pass by reference"

---

## a simple problem

given a range of positive integers:

* sum all numbers in range that divide by 3 or 5
* print the result

<!--vert-->

### version 1

```pascal
program Sum;
function sumOfMatching(s, e: integer): integer;
    var sum, i: integer;
    begin
        sum := 0;
        for i := s to e do
            begin
                if (i mod 3 = 0) or (i mod 5 = 0) then sum := sum + i
            end;
        sumOfMatching := sum
    end;
begin
    WriteLn(sumOfMatching(1, 300))
end.
```

<!--vert-->

### version 2

```pascal
program Sum;
type positiveInt = 1 .. MAXINT;
function isMatching(i: integer): boolean;
    begin isMatching := (i mod 3 = 0) or (i mod 5 = 0) end;
function sumOfMatching(s, e: positiveInt): integer;
    var sum, i: integer;
    begin
        sum := 0;
        for i := s to e do
            begin if isMatching(i) then sum := sum + i end;
        sumOfMatching := sum
    end;
begin WriteLn(sumOfMatching(1, 300)) end.
```

<!--vert-->

### version 3

```pascal
program Sum;
type positiveInt = 1 .. MAXINT;
function sumOfMatching(s, e: positiveInt): integer;
    var sum, i: integer;
    function isMatching(i: integer): boolean;
        begin isMatching := (i mod 3 = 0) or (i mod 5 = 0) end;
    begin
        sum := 0;
        for i := s to e do
            begin if isMatching(i) then sum := sum + i end;
        sumOfMatching := sum
    end;
begin WriteLn(sumOfMatching(1, 300)) end.
```

<!--vert-->

### version 4

```pascal
program Sum;
type positiveInt = 1 .. MAXINT;
function sumOfMatching(s, e, d1, d2: positiveInt): integer;
    var sum, i: integer;
    function isMatching(i: integer): boolean;
        begin isMatching := (i mod d1 = 0) or (i mod d2 = 0) end;
    begin
        sum := 0;
        for i := s to e do
            begin if isMatching(i) then sum := sum + i end;
        sumOfMatching := sum
    end;
begin WriteLn(sumOfMatching(1, 300, 3, 5)) end.
```

<!--vert-->
