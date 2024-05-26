# Standard ML

## introduction

---

### What's SML?

* SML - Standard Meta Language
* *General-purpose*, *modular*, *statically typed*, *functional* programming language.
* Proposed in 1983, first stable implementation in 1997
* A (relatively) modern dialect of ML, which was invented in 1973
* In 1970s, Robin Milner and group working at Edinburgh University on "LCF" (a theorem proover)
* ML invented as an embedded scripting language of LCF
* Many ad-hoc independent implementations, many new ideas
* 1997: first real standard

<!--vert-->

### Why SML?

* Exemplar of functional programming:
  * Forget about variables (kind of)
  * Data is immutable (again, kind of)
  * Functions are first-class values.
  * Higher lever functions

* Exemplar of **type safe** language
  * Strongly typed: no type error can go undetected
  * Statically typed: all type errors are detected at compile time

* Influenced: Haskell, OCaml, Scala, F#, Python ...

<!--vert-->

### Use cases of SML

Main applications:
* Research
* Teaching
* Few industrial applications

<!--vert-->

### Language Spirit

Robin Milner on ML:

> "ML is a general purpose programming language. First, it has **an escape and escape trapping mechanism**, well-adapted to programming strategies which may be inapplicable to certain goals. Second, it has a **polymorphic type discipline** which combines the flexibility of programming in a typeless language with the security of compile-time type checking."

<!--vert-->

### Language Spirit

Two main features emphasized by the language creator:

* Exception mechanism for disciplined management of errors
* Type system
  * Flexibility of typeless
  * Safety of typed

## Executing SML code
We will mostly execute in REPL mode.
* First prompt (-) and secondary prompt (=)
* Expressions followed by a semicolon yield a response

### Running

```text
Standard ML of New Jersey v110.79 [built: Sat Oct 26 12:27:04 2019]
- 5 + 5;
val it = 10 : int
```

<!--vert-->

### Executing SML code
For example:
* ML is usually used in a REPL
* Expressions followed by a semicolon yield a response

```sml
2 + 2;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

## Naming Values

We use the `val` keyword to name a new value:

```sml
val seconds : int = 60;
```

<!--vert-->

Using named values in expressions

```sml
val minutes = 60;
val hours = 24;

seconds * minutes * hours;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

Important note - these are **values**, not **variables**

<!--vert-->

### Values

The identifier `it` refers to the last response:

```sml
seconds * minutes * hours;

it div 24;
val secs_in_hour = it;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

## Identifiers

There are two kinds of identifiers in SML:

* Alphabetical identifiers, as found in most languages
* Special identifiers - mainly for defining new operators

<!--vert-->

### Identifiers
With identifiers we denote:

* Names of types
* Names of values (ordinary values and functions)

<!--vert-->

### Identifiers

Identifier congestion?

* Scoping
* Hiding
* No overloading!

<!--vert-->

### Alphabetical Identifiers

* Begin with a letter
* Followed by a sequence of letters, digits, `_`, or `'`
* Case sensitive
* Some alphabetical identifiers are reserved words
  * Names of operators: `and`, `if`, `then`, `else`, `orelse`, ...
  * Punctuations: `fun`, `let`, `local`, `of`, ...
  * Many more
* Examples:

    ```sml
    x
    x'
    uB40
    hamlet_prince_of_denmark
    h''3_H
    ```

<!--vert-->

### Special Identifiers

These are called "symbolic" identifiers in the SML lingo.

* A sequence of one or more of the following ``! % & $ # + - * / : < = > ? @ \ ~ \ ^ | ` ``
* Should not be one of: `: | = => -> #`
* Allowed wherever an alphabetic name is

    ```sml
    val +-+-+ = 1415;
    val <=> = "asdf";
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### ML keywords

`abstype` | `and` | `andalso` | `as` | `case` | `datatype` | `do` | `else` | `end` | `eqtype` | `exception` | `fn` | `fun` | `functor` | `handle` | `if` | `in` | `include` | `infix` | `infixr` | `let` | `local` | `nonfix` | `of` | `op` | `open` | `orelse` | `raise` | `rec` | `sharing` | `sig` | `signature` | `struct` | `structure` | `then` | `type` | `val` | `while` | `with` | `withtype`

Keywords are words that look like identifiers, but cannot be used as such; they are reserved for other purposes.

---

## TYPES

There are six "basic" types in sml: `int`, `real`, `string`, `char`, `bool`, `unit`

* These are basic since they are *atomic* and *builtin*
* There are other, user defined types which may be atomic or compound.

<!--vert-->

## primitive types

`int`, `real`, `string`, `char`, `bool`, `unit`

* These are valid identifiers and not reserved keywords!
* Technically these are predefined identifiers, naming the builtin types
* The identifiers may be used for other purposes; the underlying type may remain nameless

```sml
val int = 6;
val real = 7;
real * int - real;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### int literals

* Sequence of digits
  * 0
  * 01234
* `~` for a unary minus sign
  * `~23`
  * `~85601435654638`

<!--vert-->
#### int infix operators
`+` `-` `*` `div` `mod`

Conventional precedence (parenthesis can be dropped without change of meaning)

```sml
(((m * n) * l) - (m div j)) + j
```

---

### real literals

* Decimal point
  * `0.01`
  * `2.718281828`
  * "e" notation
  * `7E~5`
  * `~1.2E12`
  * `~123.4E~2` is the same as `~1.234`

<!--vert-->

Infix operators: `+` `-` `*` `/`

`+` `-` `*` `/`

 * Note that `+`, `-`, `*` are overloaded

<!--vert-->

### numeric types functions

* `floor` converts `real` to `int`
* `real` converts `int` to `real`
* `sqrt`, `sin`, `cos`, `tan`, `exp`, `ln` all of type `real->real`
* All need the `Math.` prefix: `Math.sqrt`

---

### strings

String literals are written in double quotes

```sml
"ML is the best";
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

Escape sequences: `\n`, `\t`, `\"`, `\\`

<!--vert-->

### string operators

Concatenation operator:

```sml
"Standard" ^ " ML";
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

Comparison of strings:

```sml
"abc" < "cba";

"zzz" > "aaa";
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### string operators

`size` returns the number of characters

```sml
size "SML";
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

Notice the syntax of function application - no parentheses!

---

### Characters

Characters (values of type `char`) are distinguished from strings of length 1 by the character `#`

```sml
"0";

#"0";
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Char operations

Conversion between strings and chars

```sml
str #"0";

String.sub ("hello", 0);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

Conversion between chars and ASCII

```sml
ord #"0";

chr it;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### boolean

Two named values: `true` and `false`

```sml
true;

false;

2 + 2 = 4;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

The names `true` and `false` are not keywords; they are predefined identifiers!

---

### tuples - Cartesian product type

* N-tuple whose components are `x1`, ..., `xn`:

    ```sml
    (x1, x2, ..., xn)
    ```

* The components can be of any type, including tuples

    ```sml
    val a = (1.5, 6.8);

    (1, 1.5);

    ("str", 1, true, (#"0", 0.1));
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### records

* Records have components (fields) identified by name

    ```sml
    val me = {name="Ofir", age=30};
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* Type lists each field as `label : type`

<!--vert-->
### records
* Selecting a field

    ```sml
    #name me;
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* Tuples **can be seen as** records with numbers as implicit field labels

    ```sml
    #2 ("one", "two", "three");
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* Note that the numbering starts with 1

---

### lists

Lists are finite sequences of elements:

```sml
[3, 5, 9];
["a", "list"];
[];
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### lists

Elements may have any type but all elements must have the same type

```sml
[(1, "one"), (2, "two")] : (int*string) list;
[[3.1], [], [5.7, ~0.6]] : (real list) list;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### If-else expressions
```sml
val x = 1;
val y = 2;
if x < y then x*x else 0;
```

<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* *if-else* is not a control structure, but an expression! (a bit like trinary operators in C)
* The two possible outcomes must be of the same type
* *else* is mandatory
---

### Mapping - functions

```sml
fun sq (x: int) = x*x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* `fun` keyword starts the function declaration
* `sq` is the function name
* `x:int` is the formal parameter with type constraint
* `x*x` is the body and it is an **expression**

<!--vert-->

### Functions

* The result of the function is the result of evaluating the **expression** of the function body with the actual parameter.
* `int->int` is the standard mathematical notation for a function type that takes an integer and returns an integer.

---

### Applying a Function

* Simple function call

    ```sml
    (sq 3);
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* When a function is called the argument is evaluated and then passed to the function

    ```sml
    sq (sq 3);
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* Parentheses are optional

    ```sml
    sq 3;
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

* Parentheses are also optional in function definitions

    ```sml
    fun sq x: int = x*x;
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Arguments and Results

* Every function has one argument and one result
* Any type can be passed/returned!!!
* Tuples are used to pass/return several values

    ```sml
    val a = (3.0, 4.0);

    fun lengthvec (x: real, y: real) = Math.sqrt (x*x + y*y);

    lengthvec a;

    lengthvec (5.0, 12.0);
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Functions as Values

* Anonymous functions with `fn` notation

    ```sml
    fn x: int => x*x;

    it 3;
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->


* The following declarations are identical

    ```sml
    fun sq x: int = x*x;
    val sq = fn x: int => x*x;
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Returning a Function as Value

* Functions can also be **returned** from other functions

    ```sml
    fun inttwice (f: int->int) =
        fn x => f (f x);
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* The arrow is **right associative** so the type of `inttwice` is equivalent to:

    ```sml
    val inttwice = fn : (int -> int) -> (int -> int)
    ```

### Returning a Function as Value

For example:

```sml
inttwice (fn x => x*x);

it 3;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Type Inference

ML deduces the types in expressions

```sml
fun facti (n, p) =
    if n=0 then p else facti (n-1, n*p);
(*val facti = fn : int * int -> int*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* Literals `0` and `1` have type `int`
* Therefore `n=0` and `n-1` involve integers so `n` has type `int`
* `n*p` must be integer multiplication, so `p` is of type `int`
* Therefore `facti` returns type `int`

---

### Type Constraints

* Certain functions are overloaded, e.g. `abs`, `+`, `-`, `~`, `*`, `<`
* The type of an overloaded function is determined from context, or is set to `int` by default
* Types can be stated explicitly

---

###  Type Inference Exercise
What will be printed for the following definitions of `min`?

<!--vert-->

```sml
fun min (x, y) = if x < y then x else y;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

```sml
fun min (x: real, y) = if x < y then x else y;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

```sml
fun min (x: string, y) = if x < y then x else y;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

```sml
fun min (x, y) : real = if x < y then x else y;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

```sml
fun min (x, y) = if x < y then x: real else y;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->
Write a function `foo` such that its type is:

```sml
val foo = fn: int * real -> real
```

Without using type annotations

```sml
...
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Polymorphic Type Checking

|                           |        | flexibility | security |
| :-----------------------: | :----: | :---------: | :------: |
|       Weakly typed        |  Lisp  |      ✔      |          |
|      Strongly typed*      | Pascal |             |    ✔     |
| Polymorphic type checking |   ML   |      ✔      |    ✔     |

As a bonus - in ML most types are inferred automatically 😎

NOTE: Pascal has type punning so its not as strongly typed as ML

---

### Polymorphic Function Definitions

* In case type inference leaves some types completely unconstrained then the definition is polymorphic
* A polymorphic type contains a type variable, e.g. 'a, 'b

    ```sml
    fun pairself x = (x, x);

    pairself 4.0;

    fun pair (x,y) = (y, x);
    ```
    <!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### functions as values - the polymorphic case

<!--vert-->
### Polymorphic Functions Exercise
What will be printed?

```sml
fun ident x = x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->
### Polymorphic Functions Exercise
What will be printed?

```sml
fun twice f = fn x => f (f x);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Polymorphic Functions Exercise
What will be printed?

```sml
fun twice f = fn x => f (f x);
twice (fn x => x * x);
it 2;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Polymorfic functions Excercise
Sometimes ML gives us a hard time..

```sml
fun twice f = fn x => f (f x);
fun ident x = x;
twice ident;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

You usually may ignore it. or use a workaround:

```sml
fn x => twice ident (x);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Functional vs. Imperative Programming

* Imperative - using commands to change the state
* Functional - stateless. using expressions recursively to calculate the result
* Example: Euclid's algorithm for the Greatest Common Divisor (GCD) of two natural numbers:

$$gcd (m,n) = \begin{cases}n,m = 0&\\gcd (n mod m,m), m>0\end{cases}$$

<!--vert-->

### GCD - Python vs. ML

An imperative Python program:

```python
def gcd (m: int, n: int) -> int:
    while m != 0:
        n, m = m, n % m
    return n
```

A functional program in Standard ML:

```sml
fun gcd (m,n) = if m=0 then n else gcd (n mod m, m);
```

Which one is more efficient? 🧐
