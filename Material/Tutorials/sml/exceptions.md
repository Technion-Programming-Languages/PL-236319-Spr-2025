# Standard ML

## exceptions

---

### exceptions - motivation

* An extensive part of code is error handling
* A function may return an answer, fail to find one or signal that a solution does not exists

<!--vert-->

### exceptions - alternative

```sml
datatype int_sol = Success of int | Failure | Impossible;

case methodA problem of
    Success s  => Int.toString s
  | Failure    => (case methodB problem of
                      Success s  => Int.toString s
                    | Failure    => "Both failed"
                    | Impossible => "No Good")
  | Impossible => "No Good"
;
```

Without exceptions, error handling can be tedious and requires explicit handling.

Sometimes we don't really know what to do with the error, so we'll simply return it

---

### exceptions usage - key concepts

* When an error is discovered we will **raise** an exception
* The exception will propagate up until someone **handles** it
> The caller of a function doesn't have to check any error values

<!--vert-->

### exceptions usage

In pseudo code:

```sml
fun inner = do_calculation
    if local_error then raise local_error,
    if global_error then raise global_error;

fun middle = inner (…) handle local_error;

fun outer = middle (…) handle global_error;
```

---

### the exception type `exn`

* In SML we can **raise** only values of specific type: `exn`
* `exn` is a special datatype with an **extendable** set of constructors and values

```sml
exception Failure;
Failure;

exception Problem of int;
Problem;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### the exception type `exn`

Values of type `exn` have all the privileges of other values ...

```sml
val p = Problem 1;
map Problem [0, 1, 2];
fun whats_the_problem (Problem p) = p;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### the exception type `exn`
... except

```sml
val x = Failure;
x = x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### raising exceptions

```sml
raise Exp
```

* Assume the expression `Exp` evaluates to `e` (and is of type `exn`)
* `raise Exp` evaluates to an <span style="color: red;">exception packet</span> containing `e`
> Important note - packets are not ML values!

<!--vert-->

### raising exceptions


All of the following "evaluate" to `raise Exp`

```sml
f (raise Exp)

(raise Exp) arg

raise (Exp1 (raise Exp)) (* Exp1 is a constructor *)

(raise Exp, raise Exp2)  (* or {a=raise Exp, b=raise Exp2} *)

let val name = raise Exp in some_expression end

local val name = raise Exp in some_declaration end
```

---

### fixing `hd` and `tl`

```sml
exception Empty;

fun hd (x :: _) = x
  | hd []       = raise Empty;

fun tl (_ :: xs) = xs
  | tl []        = raise Empty;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### handling exceptions - syntax

```sml
Exp_0 handle
    P1 => Exp_1
  | ...
  | Pn => Exp_n
```

* All `Exp_i`s must be type-compatible
* All `Pi`s must be valid patterns for the type `exn`

```sml
fun len l = 1 + len (tl l) handle Empty => 0;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### handling exceptions - semantics

```sml
Exp_0 handle Cons1 x => Exp_1
```

* Assume `Exp_0` evaluates to some `V` (which is either a value or an exception packet), then the expression evaluates to:
  * `Exp_1` - in case `V` is `raise Cons1 x`
  * `V` - otherwise (`V` may be either a normal value or a non-matching raised exception)

> `handle` is short-circuiting

> Exactly equivalent to familiar notions from C++

---

### the type of `raise Exp`

* The expression `raise Exp` is of type `'a`
* It is **not** an expression of type `exn`
* This is necessary to avoid restricting the other parts of the expression.

```sml
fun throw _ = raise Empty;
exception Underflow;
fun bar x = if x > 0 then x else raise Underflow;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### using exception handling

```sml
case methodA problem of
    Success s  => Int.toString s
  | Failure    => (case methodB problem of
                      Success s  => Int.toString s
                    | Failure    => "Both failed"
                    | Impossible => "No Good")
  | Impossible => "No Good"
```

and now with exceptions:

```sml
toString (methodA problem handle Failure => methodB problem)
  handle Failure => "Both failed"
    | Impossible => "No Good"
```
