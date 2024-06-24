# Standard ML

## errors

---

### Case #1

```sml
fun foo x y = x + y;

foo 5 -4;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

We use `-` and not `~` for negation. Actually, ML reads this as `(foo 5) - 4`, so that's why this error is there

---

### Case 2

```sml
fun foo x y = x + y;
fun bar (x, y) = x * y;

foo 2 bar(1, 2);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

Curried function application is greedy - ML reads this as 3 arguments for `foo`, and you can't pass `bar` as the second argument to `foo` - that's a type error 

---

### Case 3

```sml
fun foo [] = 0
  | foo x::xs = x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

Parentheses - needs to be `(x::xs)`. ML considers this to be a triple of `x`, `::`, `xs` and complains about being given a tuple and not a list

---

### Case 4

```sml
case "0" of
    "0" => 0
  | "1" => case 0 of _ => 1
  | "2" => 2
  | _ => 3;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

Parentheses - the inner `case` needs to be `(case 0 of _ => 1)`. Also notice that the error is a type error, but it's not to be handled as a type error. ML reads the `"2"` and later `_` case as belonging to the second case and not the first one

---

### Case 5

```sml
fun foo (a: {x: int, y: int}) = x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

`x` is not a field. It's part of the type of `a`. The correct way is `#x a`

---

### Case 6

```sml
type A = {x: int, y: int};
fun foo a = #s1 a;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

ML cannot do type inferrence to deduce the entire type of `a`, so it results in an error. ML cannot do partial type inferrence

---

### Case 7

```sml
Math.pow(2.0, 3.0) - 1;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

Type mismatch. `pow` returns `real`

<!--vert-->

### Case 8

```sml
fun f x = Math.sqrt x;
if (f 9.0 = f 9.0) then 1 else 0;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

`real` is a not a polymorphic equality type - cannot compare `real`s. This is a type error because in ML types that are able to be compared using `=` are denoted by `''a`, and `real` is `'a` but not `''a`

---

### Case 9

```sml
fun f g x = if g = g then g x else 0;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

Ditto. `g` is a function (actually, `'a -> int`) and functions are not polymorphic equality types. However, since it is first used in a comparison and only then as a function, the error will be reported in the function application and not in the equality. It actually concludes it cannot be a function, rather than concluding it cannot be a polyEqual type

---

### Case 10

```sml
fun f (a:{s: int, r: int}) = {s: (#s a), r: (#r a)};
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

`:` denotes type, we need to use `=` in the returned expression to denote a value. Another common error: `{(#s a), (#r a)}`

---

### Case 11

```sml
fun f a:{s: int, r: int} = {s = (#s a), r = (#r a)};
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

The type here in the constraint binds to the function - `f`, rather than to `a`, like it may seem. This apparently should not cause an issue, because that is the actual type we are returning, however, it does leave `a` without a precise type constraint and this is a problem because like before, ML cannot do partial type inferrence and it cannot conclude the exact type for `a`, just some of its fields

---

### Case 12

```sml
local
  fun rec (a, _, 0) = a  
    | rec (a, b, n) = rec (a + b, a, n - 1)
in
  fun fib n = rec (1, 1, n)
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

`rec` is a keyword...

---

### Case 13

```sml
val x = (1 = 1) and (2 = 2);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

`andalso` is logical AND and not `and`. Also, `orelse` and not `or`

---

### Case 14

```sml
val x = "Andrey\n";
fun f () = print ("My name is " ^ x);
val x = "Maroon\n";
f (); 
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

Functions freeze the values they refer to, and do not get updated when the identifier is reused

---

### Case 15

```sml
Math.pow (2.0, 3.0);
floor it = 8;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

This specifically came up in the home ex. Terribly annoying floating-point arithmetic error. When doing integer arithmetic, implement manually with a recursive function.

---

### Case 16

```sml
fun a () = b () and fun b () = a ()
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Explanation

We don't repeat the `fun` keyword after `and`. Ditto for `val`, `datatype`
