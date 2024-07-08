# Standard ML

## sequences

---

### lazy lists

* Elements are not evaluated until their values are required
* **May** be infinite
* Example: a sequence of all even integers `$0, 2, -2, 4, \ldots$`

<!--vert-->

### lazy lists in ML

ML evaluates `E` in `Cons(x,E)`, so to obtain laziness we must write `Cons(x, fn()=>E)`

```sml
datatype 'a seq = Nil
    | Cons of 'a * (unit -> 'a seq);

fun take s 0 = []
  | take Nil _ = []
  | take (Cons (x, xf)) n = x :: take (xf ()) (n - 1);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### examples of sequences

`$1, 2, 3, 4, \ldots$`

```sml
fun from k = Cons (k, fn () => from (k + 1));

from 1;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
take it 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### examples of sequences

`$0, 2, -2, 4, \ldots$`

```sml
fun from_even n = let
    val next = if n > 0 then ~n else ~n + 2
  in
    Cons (n, fn () => from_even next)
  end;

from_even 0;
```

<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
```sml
take it 10;
```

<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Processing sequences

`squares` takes a sequence of integers and returns a sequence of their squares:

```sml
fun squares Nil = Nil
  | squares (Cons (x, xf)) =
        Cons (x * x, fn () => squares (xf ()));

squares (from 1);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
take it 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `addq`
Implement `addq` that takes two integer sequences and adds them element-wise

```sml
...
(*val addq = fn : int seq * int seq -> int seq*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `addq`
```sml
fun addq (Cons (x, xf), Cons (y, yf)) =
        Cons (x + y, fn () => addq (xf (), yf ()))
  | addq _ = Nil;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
addq (from 1, from 1);
take it 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `appendq`

Implement `appendq` that appends two sequences

```sml
...
(*val appendq = fn : 'a seq * 'a seq -> 'a seq*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `appendq`
```sml
fun appendq (Nil, yq) = yq
  | appendq (Cons (x, xf), yq) =
        Cons (x, fn () => appendq (xf (), yq));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

What would `appendq(xq,yq)` be if `xq` is infinite?

<!--vert-->

#### `mapq`

Implement `mapq` that applies a function on the elements of a sequence

```sml
...
(*val mapq = fn : ('a -> 'b) -> 'a seq -> 'b seq*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `mapq`
```sml
fun mapq f Nil            = Nil
  | mapq f (Cons (x, xf)) =
        Cons (f x, fn () => mapq f (xf ()));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
mapq (fn x => x * 3) (from 1);
take it 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `filterq`

Implement `filterq` that filters a sequence based on a predicate

```sml
...
(*val filterq = fn : ('a -> bool) -> 'a seq -> 'a seq*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `filterq`
```sml
fun filterq pred Nil = Nil
  | filterq pred (Cons (x, xf)) =
        if pred x
        then Cons (x, fn () => filterq pred (xf ()))
        else filterq pred (xf ());
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
filterq (fn x => x mod 2 <> 0) (from 1);
take it 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `interleaveq`

Implement `interleaveq` that interleaves two sequences.

e.g.: Interleaving `1,2,3,...` and `11,12,13,...` returns: `1,11,2,12,3,13,4,...`

```sml
...
(*val interleaveq = fn : 'a seq * 'a seq -> 'a seq*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `interleaveq`
```sml
fun interleaveq (Nil, yq)       = yq
  | interleaveq (Cons (x, xf), yq) =
        Cons (x, fn () => interleaveq (yq, xf ()));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
interleaveq (from 1, from 11);
take it 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `dropq`
`dropq` takes a sequence `s` and a positive number `n` and returns `s` without its first `n` elements

```sml
...
(*val dropq = fn: 'a seq -> int -> 'a seq*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `dropq`
```sml
fun dropq seq 0 = seq
  | dropq Nil _ = Nil
  | dropq (Cons (x, xf)) n = dropq (xf ()) (n - 1);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
dropq (from 1) 10;
take it 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `seqToList`
`seqToList` takes a sequence and returns a list of its elements

```sml
...
(*val seqToList = fn: 'a seq -> 'a list*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `seqToList`
```sml
fun seqToList Nil = []
  | seqToList (Cons (x, xf)) = x :: (seqToList (xf ()));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->
#### `listToSeq`
`listToSeq` takes a list and returns a sequence of its elements

```sml
...
(*val listToSeq = fn: 'a list -> 'a seq*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `listToSeq`
```sml
fun listToSeq [] = Nil
  | listToSeq (x :: xs) = Cons (x, fn () => listToSeq xs);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Exam Question
![q1](../../imgs/q1.png)

<!--vert-->

```sml
...
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->
#### `fraction`

```sml
fun fraction m n =
  if m mod n = 0
  then Nil
  else Cons (m * 10 div n mod 10, fn () => fraction (m * 10) n);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->


```sml
fraction 1 7;
take it 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Exam Question
![q2](../../imgs/q2.png)

<!--vert-->

```sml
...
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

#### `lazy_divide`

```sml
fun lazy_divide m n = (m div n, fraction (m mod n) n);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---
## Sequences exercise
#### (a hard one in fact...)

<!--vert-->

Let's define a lazy tree datatype, using sequences:

```sml
datatype 'a seq = Nil | Cons of 'a * (unit -> 'a seq)

datatype 'a option = NONE | SOME of 'a;

datatype 'a node =
  Node of 'a * (unit -> 'a node option) * (unit -> 'a node option);

type 'a lazy_tree = unit -> 'a node option;

fun take s 0 = []
  | take Nil _ = []
  | take (Cons (x, xf)) n = x :: take (xf ()) (n - 1);

```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

Let's define some trees:

```sml
fun t1 () = NONE;
fun t2 0 () = SOME (Node (0, t1, t1))
  | t2 n () = SOME (Node (n, t2 (n div 2), t2 (n - 1)));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

Implement lazy bfs traversal of lazy trees

```sml
...
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

```sml
local
  fun aux [] [] = Nil
    | aux [] ts = aux (map (fn t => t ()) ts) []
    | aux (NONE :: ns) ts = aux ns ts
    | aux ((SOME (Node (h, l, r))) :: ns) ts = 
    	Cons(h, fn () => aux ns (ts @ [l, r]))
in
  fun bfs t = aux [t ()] []
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
take (bfs (t2 10)) 10;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
