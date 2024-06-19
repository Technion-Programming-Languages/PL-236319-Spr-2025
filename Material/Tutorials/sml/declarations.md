# Standard ML

## Declarations

---

### Reminder: Values and Types

What's a **value**?

* Integers are values
* A pair of an integer and real is a value
* Every function is a value

<!--vert-->

### Reminder: Values and Types

Every value in ML has a **type**:

* Some types are atomic
* Some types are builtin
* Some types may be both builtin and atomic
* Other types are compound (made from smaller types)

Remember: not everything in ML is a value, types are not values!

<!--vert-->

### where do values come from?

During execution, the program generates more values by using **operators** for **computation**

* `div` creates values of type int
* `fn ? => ?` creates values which are functions
* `fun x (t) = ...` creates a value which is a fucntion and names it

A value constructor is always an operator

<!--vert-->

### where do values come from?

Important Note: a type constructor is not an operator, it takes types and creates a new type

* `->`
* `*`
* `{...}`

<!--vert-->

### where do values come from?

Values can also be introduced by the programmer:

* Atomic values: every literal is a value
* Composite values: expressions, function definitions

<!--vert-->

### declarations

* Making new values out of previous values and literals
* Providing names for this value
* Making new types out of previous types (builtin and user defined)
* Providing names for these new types

<!--vert-->

### REPL

For every new value the programmer inserts, expression or declaration, the ML engine:
* Infers type of that value: `int`, `int * real`, `'a -> int -> int`, ...
* Computes the value (if it is an expression)
* Associates the name `it` with this value

---

### Example: The Area of a Circle

$$area = \pi \cdot r^2$$

```sml
val pi = 3.14159;

fun area r = pi * r * r;

area 2.0;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Identifiers in ML

* `val` declaration binds a name to a value
* Names are not variables!
* A name can not be used to change its value (actually a constant)
* A name can be reused for another purpose
  * By scoping rules
  * By hiding a name in an outer scope
  * By redefinitions to the REPL...

```sml
val pi = "pi";
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Identifiers in ML

In case a name is declared again, the new meaning is adopted afterwards

```sml
pi;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

However, this does not effect existing uses of the name

```sml
area 1.0;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### is it a good feature?

<div style="text-align: left">
👍 redefining cannot damage your program

👎 redefining may have no visible effect

⚠️ when modifying a program, be sure to recompile the entire file
</div>

---

### val rec

We can define a function using val:

```sml
val sq = fn x => x * x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

What about recursive functions?

```sml
val f = fn n => if n = 0 then 1 else n * f (n - 1);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### val rec

In order to do so, we may use `val rec`:

```sml
val rec f = fn n => if n = 0 then 1 else n * f (n - 1);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

NOTE:

`fun` VS `val rec` is a matter of taste

It is always a question when does a binding get into effect

* In Pascal and C a function 'int f(double d) **** {...}'
* In C (and Pascal) this applies also to types:

  ```C
  struct X *p; // OK Struct X is an incomplete type 
  struct X y; // Error struct X not defined
  struct X { int a; }; // Complete definition of struct x.
  struct Y { int b; } Y; // Y is variable of type 'struct Y'
  typedef struct Z {int c; } Z; // Z is alias to type struct Z.
  ```

  * C: `struct X *y; struct X { ....}`
    * gives body to type `struct X`
    * the type struct X exists even before the type `X` never exists

---

### Pattern Matching

Patterns can be used to simplify function definitions

```sml
fun factorial 0 = 1
  | factorial n = n * factorial (n - 1);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

When the function is called, the first pattern to match the argument determines which expression on the right hand side will be evaluated

<!--vert-->

### Pattern Matching

Patterns can consist of:
  * Constants - int, real, string, ...
  * Constructs - tuples, datatype constructors
  * Variables - all the rest
  * Underscore - a wildcard
> Note: matching is recursive

<!--vert-->

### Pattern Matching

What will be printed?

```sml
fun foo (x, 1) = x
  | foo (1, _) = 0
  | foo _ = ~1;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
foo (3, 1);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
foo (1, 3);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
foo (2, 2);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
foo (1, 1);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Patterns using `case`

```sml
case E of P1 => E1 | ... | Pn => En
```

```sml
case 7 of
    0 => "zero"
  | 1 => "one"
  | 2 => "two"
  | n => if n < 10 then "lots" else "lots &lots";
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* If `Pi` is the first to match then the result is `Ei`
* No symbol terminates the case expression - enclose in parentheses to eliminate ambiguity

---

### Type aliasing

You can give a new name to an existing type.

```sml
type vec = real * real;

infix ++;
fun (x1, y1) ++ (x2, y2) : vec = (x1 + x2, y1 + y2);

(3.6, 0.9) ++ (0.1, 0.2) ++ (20.0, 30.0);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
> Note: the new name is only an alias
---

### Declarations inside an expression

In case you want to limit a scope of a declaration, you may use a `let` expression:
```sml
let D in E end
```

```sml
fun gcd (n, m) = if m = 0 then n else gcd (n mod m, m);

fun fraction (n, d)=
  let 
    val com = gcd (n, d)
  in
    (n div com, d div com)
  end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Declarations inside an expression

`D` may be a compound declaration

```sml
let
  val x = 5
  val y = 17
in
  x * y
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Declarations inside an expression

`let` can be simulated using anonymous functions

```sml
fun fraction (n, d) = (fn c => (n div c, d div c)) (gcd (n, d));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Nested scopes

```sml
fun sqroot a =
  let  
    val acc = 1.0e~10
    fun findroot x =
      let 
        val nextx = (a / x + x) / 2.0
      in 
        if abs (x - nextx) < acc * x
        then nextx
        else findroot nextx
      end
  in 
    findroot 1.0 
  end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Declarations inside a Declaration

We may also use a `local` declaration:

```sml
local D1 in D2 end
```

```sml
local
  fun itfib (n, prev, curr): int =
    if n = 1 then curr
    else itfib (n - 1, curr, prev + curr)
in
  fun fib n = itfib (n, 0, 1)
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

(`D1` is visible only within `D2`)

<!--vert-->

### Comparing `let` and `local` (1)

```sml
fun fib n = let
  fun itfib (n, prev, curr): int =
    if n = 1 then curr
    else itfib (n - 1, curr, prev + curr)
in
  itfib (n, 0, 1)
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
local
  fun itfib (n, prev, curr): int =
    if n = 1 then curr
    else itfib (n - 1, curr, prev + curr)
in
  fun fib n = itfib (n, 0, 1)
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Comparing `let` and `local` (2)

```sml
fun pow4 n: int = let
  val n2 = n * n
in
  n2 * n2
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

NOTE: a declaration in a `let` expression may refer to a parameter of the enclosing function

<!--vert-->

### Comparing `let` and `local` (3)

```sml
local
  val x = pow4 5;
in
  val y = x + 2;
  val z = x * x;
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

NOTE: the "body" of `local` may contain multiple declarations

<!--vert-->

### Comparing `let` and `local` (4)

```sml
local
  val x = pow4 5
in
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

NOTE: the "body" of `local` may be empty

---

### Simultaneous declarations (collateral)

```sml
val ID1 = E1 and ... and IDn = En
```

* Evaluates `E1`, ..., `En`
* And only then declares the identifiers `ID1`, ..., `IDn`

```sml
val x = 3;
val y = 5;
val x = y and y = x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Mutually recursive functions

$$\frac{\pi}{4}=\sum_{k=0}^\infty \frac{1}{4k+1} - \frac{1}{4k+3} = 1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} - \cdots$$

```sml
fun pos d = neg (d - 2.0) + 1.0 / d
and neg d = if d > 0.0 then pos (d - 2.0) - 1.0 / d
                       else 0.0;

fun sum (d, one) =
    if d > 0.0
    then sum (d - 2.0, ~one) + one / d
    else 0.0;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
