# Standard ML

## Lists Exam Questions
#### (and solutions)

---

#### exercise 1

Implement `map` using `foldl`

```sml
val foldl = fn : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b;
val map = fn : ('a -> 'b) -> 'a list -> 'b list;
```

```sml
fun map f inpList = foldl
    _
    _
    inpList
;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
map (fn x => x * 2) [1, 2, 3, 4];
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
<!--vert-->

#### exercise 1 - solution

```sml
fun map f inpList = foldl
    (fn (v, l) => l @ [f v])
    []
    inpList
;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
map (fn x => x * 2) [1, 2, 3, 4];
(* val it = [2, 4, 6, 8] : int list *)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
<!--vert-->

#### exercise 2

`insSort` (insertion sort) sorts a list according to a given less-then function.

```sml
val foldr = fn : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b;
val insSort : ('a * 'a -> bool) -> 'a list -> 'a list;
```

```sml
fun insSort lt inpList = foldr
    _
    _
    inpList
;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
insSort (op<) [1, ~3, 5, 0];
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 2 - solution

```sml
fun insSort lt inpList = foldr
    (let fun ins v [] = [v]
       	   | ins v (x :: xs) = if lt (v, x) then v :: x :: xs else x :: (ins v xs)
     in (fn (a, l) => ins a l) end)
    []
    inpList
;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
insSort (op<) [1, ~3, 5, 0];
(* val it = [~3, 0, 1, 5] : int list *)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 3

Let's define:

```sml
fun upto m n = if (m > n)
    then []
    else m :: (upto (m + 1) n)
;

infix o;
fun f o g = fn x => f (g x);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 3a

What will be printed?

```sml
val a = map (upto 2) (upto 2 5);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 3a - solution

```sml
val a = map (upto 2) (upto 2 5);
(* val a = [[2], [2, 3], [2, 3, 4],[2, 3, 4, 5]] : int list list *)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 3b
What will be printed?

```sml
map
    (
        (fn f => null (f ()))
        o
        (fn t => fn () => tl t)
    )
    a
;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->
#### exercise 3b - solution

```sml
map
    (
        (fn f => null (f ()))
        o
        (fn t => fn () => tl t)
    )
    a
;
(* val it = [true, false, false, false] : bool list *)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 3c
What will be printed?

```sml
map
    (List.filter (fn t => t mod 2 = 0))
    a
;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 3c - solution

```sml
map
    (List.filter (fn t => t mod 2 = 0))
    a
;
(* val it = [[2], [2], [2, 4], [2, 4]] : int list list *)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 4

Implement a tail recursive `append`

```sml
fun append ...
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
append ([1, 2, 3], [4, 5, 6]);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
**reminder**:

```sml
infix @;
fun []      @ ys = ys
  | (x::xs) @ ys = x :: (xs @ ys);
```

<!--vert-->
#### exercise 4 - solution

```sml
local
  fun aux([], ys) = ys
    | aux(x :: xs, ys) = aux (xs, x :: ys)
in
  fun append (xs, ys) = aux (aux (xs, []), ys)
end;
```

<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
append ([1, 2, 3], [4, 5, 6]);
(* val it = [1, 2, 3, 4, 5, 6] : int list *)
```

<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 5

Implement `flatten` using `foldr`

```sml
flatten : 'a list list -> 'a list;
```

```sml
fun flatten ...
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
flatten [[1, 2, 3], [4, 5, 6], [], [7, 8, 9]];
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### exercise 5 - solution

```sml
fun flatten xs = foldr (op@) [] xs;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
flatten [[1, 2, 3], [4, 5, 6], [], [7, 8, 9]];
(* val it = [1, 2, 3, 4, 5, 6, 7, 8, 9] : int list *)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

