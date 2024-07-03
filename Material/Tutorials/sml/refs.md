# Standard ML

## references

---

### pure functional programming

Pure functional programming is achieved when:
* All data is immutable
* All functions are pure, which means:
    1. They have no side-effects
    1. They are completely deterministic

Pure functional programming has its advantages, however it is not practical for most use cases.

<!--vert-->

### pure functional programming

So far we treated SML as a pure functional programming language.

Now is a good time to tell you that this is not entirely true...

---


### ref cells

In SML, we may use `ref` to create a **mutable** cell:

```sml
val x = ref 4;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### ref cells

`ref` is a constructor and as such is also a function:

```sml
ref;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### ref cells

We may use `:=` to replace a cell's contents:

```sml
val x = ref 0;
x := 15;
x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

> Note that `:=` returns `()`

```sml
val := = fn : 'a ref * 'a -> unit
```

<!--vert-->

### ref cells

We may use `!` to get the cell's content:

```sml
val x = ref 8;
!x;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
val ! = fn : 'a ref -> 'a
```

---

### sequencing with `;`

`;` is used to sequence expressions (with side-effects)

```sml
fun swap x y =
    (x := !x + !y ; y := !x - !y ; x := !x - !y);

val x = ref 1 and y = ref 2;
swap x y;
(!x, !y);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### sequencing with `;`

An expression created by `;` evaluates to the value of the last expression

```sml
val x = ref 42;
(x := !x * !x; !x);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### example - memoization

Memoization is an optimization technique used to speed up computations by caching results.

This is technique is applied to pure functions and relies on the fact that these are deterministic.

<!--vert-->

### example - memoization

For each function `f` that receives an argument `x` we store in memory pairs of `x` and `f(x)` values.

<!--vert-->

### example - memoization

When `f` is called with `x` we check if `f` was already called with `x` before. If so, we return the cached value, otherwise we compute `f(x)`, store it in memory and return it.

<!--vert-->

### example - memoization

First let's define a type for our cache memory (memoizer):

```sml
type (''a, 'b) memoizer = {max_size: int, memory: (''a * 'b) list ref};
```

<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### example - memoization

`memoizer_put` will let us store new values in the cache memory:

```sml
fun memoizer_put (memo: (''a, 'b) memoizer) x y =
	let 
      val state = #memory memo
    in
      state :=
          (if length (!state) < #max_size memo then
              !(state)
          else
              tl (!state))
          @ [(x, y)]
    end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### example - memoization

`memoize` will be our memoization function, i.e. it will apply the memoization technique to a given function:

```sml
fun memoize (memo: (''a, 'b) memoizer) f x =
    
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### example - memoization

Now let's apply memoization to the Fibonacci function:

```sml
local
    val memo = {max_size=10, memory=ref []}
in
fun fib 0 = 0
  | fib 1 = 1
  | fib n = let
        val aux = memoize memo fib
    in
        aux (n - 1) + aux (n - 2)
    end
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### example - memoization

Let's compare:

```sml
fib 43;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
fun fib_exp 0 = 0
  | fib_exp 1 = 1
  | fib_exp n = fib_exp (n - 1) + fib_exp (n - 2);
fib_exp 43;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
