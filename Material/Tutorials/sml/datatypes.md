# Standard ML

## Datatypes

---

### datatype

`datatype` is a mechanism for defining **new** types

* **Implements** the theoretical type constructor of disjoint union
* **Generalizes**:
  * The `NULL` pointer of C, Pascal, Java
  * Enumerated types, as found in Pascal, C, and Java
  * Union types, as found in Pascal and C
  * Branding, as done by Pascal's TYPE, but difficult to achieve in Java and C
* Is **essential**: cannot do lists, trees, etc., without it

> Not to be confused with `type`, which is a mechanism for giving new names to existing types

<!--vert-->

### datatype

`datatype` is an SML type constructor:

* given: a list of types and list of tags
* produce: a new type out of these

<!--vert-->

### Concrete Datatypes

Types created using `datatype` are **concrete** - these can be constructed and taken apart

ML's datatypes have two kinds of values: **atomic** and **composite**

---

### Enumeration Types

```sml
datatype single = only;

only;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

`only` denotes the only value of type `single` (isomorphic to `unit`)

<!--vert-->

### Enumeration Types

order doesn't matter

```sml
datatype bool' = true' | false';
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Enumeration Types

Datatypes allow pattern matching:

```sml
datatype piece = king | queen | rook | bishop | knight | pawn;

fun value king = Real.posInf (*infinity*)
  | value queen = 9.0
  | value rook = 5.0
  | value (bishop | knight) = 3.0
  | value pawn = 1.0;

value bishop;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Type Branding

If we use builtin types only, we may insert unwanted errors easily:

```sml
fun a m f = f / m;

val (body_mass, engine_force) = (0.0122, 50.0);

a engine_force body_mass; (* oops *)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Type Branding

Type aliasing doesn't help

```sml
type mass = real and force = real and acceleration = real;

fun a (m:mass) (f:force) : acceleration = f / m;

a engine_force body_mass; (* still oops *)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Type Branding

Simulate branding using `datatype`:

```sml
datatype mass = Kg of real;
datatype force = Newton of real;
datatype acceleration = m_s'2 of real;

fun a (Kg m) (Newton f) = m_s'2 (f / m);

val body = Kg 2.0;
val engine = Newton 50.0;

a body engine; (*OK*)

a engine body; (*Error*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Constructors (of SML)

In SML constructors are functions:

```sml
datatype mass = Kg of real;
datatype force = Newton of real;
datatype acceleration = m_s'2 of real;

Kg;

Newton;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Variant Types in Pascal

#### definition

```Pascal
type kind = (point, line, circle, rectangle)
shape = record 
 case k: kind of
  point: (* No fields in this case *) 
  line: length:real; 
  circle: radius:real;
  Rectangle:  width, length: real; end
end
```

<!--vert-->

#### usage (similar case structure)

```Pascal
function area(s: shape) : real;
begin 
  case s of
    point,Line: area:=0
    cirle: area := 3.14 * radius * radius;
    rectnagle: area := width * length;
  end
end
```

Type safety? none.

* Same memory block is allocated to either (nothing) / (length) / (radius) / (width + height)
* Its the rogrammer's responsibility to make sure that only the correct fields are accessed

---

## redoing variant records with datatype

```sml
datatype shape =
    point
  | Line of real
  | Circle of real
  | Rectangle of real * real;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

NOTE:

* use Cartesian product instead of record
* fewer keywords
* no semicolons
* minimal baggage

<!--vert-->

### Pattern Matching

In SML we also get type safety and pattern matching out of the box:

```sml
fun area (point | Line _) = 0.0
  | area (Circle r) = Math.pi * r * r
  | area (Rectangle (w, h)) = w * h;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

NOTE:

pattern matching is a generalization of switch

---

⚠️ Constructors cannot be rebound by `val`

```sml
val point = point; (*OK*)
val point = 5.3; (*Error*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Recursive Datatypes

🛈 Every `intlist` is either `NIL` or `head $$ tail`

```sml
datatype intlist =
    NIL
  | $$ of int * intlist;

infixr $$;

fun length NIL     = 0
  | length (x $$ xs) = 1 + length xs;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Polymorphic Datatypes

🛈 Every `list` is either `nil` or `head::tail`

```sml
datatype 'a list =
    nil
  | :: of 'a * ('a list);
infixr ::;
```

```sml
"hello" :: "world" :: nil;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Option Example

```sml
datatype 'a option = NONE | SOME of 'a;

fun head []     = NONE
  | head (x :: _) = SOME x;

head [1, 2, 3];

head (tl [1]);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### Union Example

```sml
datatype ('a, 'b) union = type1 of 'a
  | type2 of 'b;

val five = type1 5;

val hello = type2 "hello";

val five_or_hello = if true then five else hello;

val int_char_list = [type1 5, type2 #"a"];
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Trees

```sml
datatype 'a tree =
    Nil
  | Br of 'a * ('a tree) * ('a tree);

fun Leaf x = Br (x, Nil, Nil);

val tree2 = Br (2, Leaf 1, Leaf 3);
val tree5 = Br (5, Leaf 6, Leaf 7);
val tree4 = Br (4, tree2, tree5);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
fun size Nil = 0
  | size (Br (v,t1,t2)) = 1 + size t1 + size t2;

size tree4;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### Binary Search Trees
Example: implementing an associative map using trees
* Keys are `int`s
* Values may be anything
* Assumption: the tree is sorted

<!--vert-->

### Binary Search Trees
```sml
val cmp = Int.compare;

fun get (Br ((node_k, v), left, right)) k = 
  case cmp (node_k, k) of
    EQUAL   => v
  | GREATER => get right k
  | LESS    => get left k
;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->
### Binary Search Trees Excercise

Implement `insert` that takes a BST, a key `k` and a value `v` and returns an updated BST with the node `(k, v)`

```sml
val insert = fn : (int * 'a) tree -> int -> 'a -> (int * 'a) tree
```

<!--vert-->

### Binary Search Trees Excercise

```sml
...
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->


### Binary Search Trees Excercise

```sml
fun insert Nil k v = Br ((k, v), Nil, Nil)
  | insert (Br (node, left, right)) k v = 
    case cmp (#1 node, k) of 
      EQUAL   => Br ((k, v), left, right)
    | GREATER => Br (node, left, insert right k v)
    | LESS    => Br (node, insert left k v, right);
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
