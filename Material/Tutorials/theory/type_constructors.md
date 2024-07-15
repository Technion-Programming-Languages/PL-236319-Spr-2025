
# type constructors

---

### Types

> A type is defined as a set of values.

Most programming languages have at least some basic built-in types.

However, usually we would like to use some more complex types or even define new types ourselves.

<!--vert-->

### type constructors

Type constructors are operators that take a type and return a new type.

---

## Type Constructor Examples

---

### power set

> $\wp T = \\{ T' | T' \subseteq T \\}$

Which languages support the power set type constructor?

<!--vert-->

### power set

In Pascal:

```pascal
type Alphabets = set of 'A' .. 'Z';
```

In Python:

```python
s: set[int] = {1, 2, 3}
```

---

### cartesian product

* Notation: $T_1\times \cdots \times T_n$
* Composition: $\langle\cdot,\ldots,\cdot\rangle$
* Decomposition: $i(\cdot)$ or $(\cdot)\\#i$

How is cartesian product represented in languages you know?

<!--vert-->

### cartesian product

In SML:

```sml
type product = int * real * string;
```

In TypeScript:
```typescript
type product = [number, number, string];
```

<!--vert-->

### properties of cartesian products

* Commutativity - never!
* Associativity - depending on the PL semantics.

---

### integral exponentiation

* Integral exponentiation makes homogenous tuples
* Notation: $T^n = T \times \overset{\text{n times}}{\cdots} \times T$

<!--vert-->

### integral exponentiation(ish)

In C/C++:

```c
typedef int exp[10];
```

> C compiler will actually treat this as a `int*`

---

### unit type

A type with only one value

(similar to `void` but not really)

<!--vert-->

### unit type

In SML, either `{}` or `()`:

```sml
();
(*val it = () : unit*)

```

```sml
() = {};
(*val it = true : bool*)

```

---

### branding

* Notation: $l(T)$
* Composition $l(\cdot)$
* Decomposition: $l(\cdot)$

> Branding "requirement" - $\forall v\in T: v \neq l(v)$

<!--vert-->

### branding

In SML:

```sml
datatype X = X of int;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### branding

Note that `type` creates an alias, it doesn't brand

```sml
type X = int;
fun (x: X): int = x; (*OK*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### records

* Notation: $\{ l_1: T_1,\ldots,l_n: T_n \}$
* Composition: $\{ l_1=\cdot,\ldots,l_n=\cdot \}$
* Decomposition: $l_i(\cdot)$

<!--vert-->

### records

In SML:

```sml
type record = { x: int, y: real };
```

In C:
```c
struct record = { int x; int y; };
```

In TypeScript:
```typescript
type record = { x: number, y: number };
```

---

### disjoint union

* Notation: $l_1(T_1)\cup\cdots\cup l_n(T_n)$
* Composition: $l_i(\cdot)$

<!--vert-->

### disjoint union

In SML:

```sml
datatype ('a, 'b) union = A of 'a | B of 'b;
```

In TypeScript (not actually disjoint):
```typescript
type union = string | number;
```

<!--vert-->

A (true) enum can be thought of as a disjoint union of branded unit types

$$(l_1, \ldots, l_n) = l_1(Unit) + \ldots + l_n(Unit)$$

> Do C enums follow this definition? How about Pascal enums?

---

### The bottom type

A type that has **no** values

> Formally - $\emptyset$

<!--vert-->

### The bottom type

In TypeScript, using the `never` keyword:
```typescript
let x: never;
x = 2 /* Type error, no matter what is on the right side of the assignment */
```

In C - we will use *void*

<!--vert-->

### The bottom type - Not in SML!

A datatype in SML can never be empty.

Best approximation for a function that never returns:
* Return type is `Unit`
* Function always throws an exception

---

### the Any/all/top type

A type that contains **all** values in the language.

<!--vert-->

### the Any/all/top type

In TypeScript, using the `unknown` keyword:
```typescript
let x: unknown;
x = 2;
x = 'Hello';
x = [ true, false ];
```

---

### mapping and partial mapping

Notation: $S\rightarrow T$

<!--vert-->

### mapping and partial mapping

Practically - a function type!

In SML:

```sml
type ('a, 'b) F = 'a -> 'b;
```

In TypeScript:
```typescript
type pred = (unknown) => boolean;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### simple recursive

Notation: $\tau = E(\tau,T_1,\ldots,T_n)$

<!--vert-->

### simple recursive

In SML:

```sml
datatype 'a list =
    nil
  | :: of 'a * 'a list;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### multiple recursive

Notation:

$$\tau_1 = E(T_1,\ldots,T_m, \tau_1,\ldots,\tau_n)$$
...
$$\tau_n = E(T_1,\ldots,T_m, \tau_1,\ldots,\tau_n)$$

<!--vert-->

### multiple recursive
In SML:

```sml
datatype 'a foo = Foo of ('a * 'a bar)
and 'a bar = Bar of 'a foo | None;

Foo (1, Bar (Foo (2, None)));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
