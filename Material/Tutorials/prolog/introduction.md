# Prolog

## introduction

---

### What is Prolog?

* Prolog - **Pro**gramming in **Log**ic.
* A compiled, *Untyped*, *declarative* language.
* Originally developed for AI applications.
* First released in the 1970s.

<!--vert-->

### Logic/Declarative Programming

Common use cases include:
* Database queries.
* Rule-based systems.
* Automated Reasoning.

In general - any problem that can be easily expressed in terms of logic or a set of constraints.

<!--vert-->

### Advantages

* Concise and readable code.
* Easy to express complex problems.
* Modular and Extensible.

<!--vert-->

### Disadvantages

* Not suitable for all problems.
* Usually not as performant as other languages.

---

### Using Prolog

A Prolog program consists of a set of *facts* and *rules*. Given a program, we can make *queries* about these rules using a REPL.

In this class we will use *Swi-Prolog*.

<!--vert-->

### Typical Workflows

Usually we will use Prolog in one of two ways:
1. Open the REPL over a program and make queries.
1. Dynamically add facts and rules (or even load programs) using the REPL.

---

### Terms

Terms are the basic building blocks of Prolog programs.

Analogous to *expressions* in other languages.

<!--vert-->

### terms - atoms

the simplest term is an **atom**, the following are atoms:

```prolog
john
$<@
'an atom'
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

### String atoms

* A string of letters, digits, and an underscore starting with a **lower-case letter**: `anna` `x_25` `nil`
* A string of special characters (`+ - * / < > = : . & _ ~`): `$<@` `<---->` `.:.`
* A string of characters enclosed in single quotes: `'Tom'` `'2A$'`

<!--vert-->

### Numeric atoms

* Integers: `123` `-42`
* Real numbers: `3.14` `-0.573` `2.4e3`

<!--vert-->

#### Variables

A **variable** is a string of letters, digits and an underscore starting with an upper-case letter or an underscore

```prolog
X_25
_result
```

<!--vert-->

### compound terms

A **compound term** comprises a *functor* and *arguments*.

```prolog
course(236319, pl)
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

A functor `f` of arity `n` is denoted `f/n`.

<!--vert-->

A **fact** is a term that we define to be true in our program.

```prolog
eats(bunny, carrot).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

This fact states that the **predicate** `eats` holds for the atoms `bunny` and `carrot` terms.

<!--vert-->


Facts can have any arity:

```prolog
summer.
sad(john).
plus(2, 3, 5).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

A finite set of facts constitutes a program:

```prolog
mammal(rat).
mammal(bear).
fish(salmon).
eats(bear, honey).
eats(bear, salmon).
eats(rat, salmon).
eats(salmon, warm).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" --> 

<!--vert-->

Facts can contain variables:

```prolog
likes(X, course236319).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" --> 

Variables are universally quantified, so this fact is equivalent to:

$$\forall X: likes(X, course236319)$$

<!--vert-->

### queries

A **query** is a conjunction of goals:

```prolog
?- eats(X, salmon), eats(X, honey).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" --> 

Variables are existentially quantified, so this query is equivalent to:

$$\exists X,eats(X, salmon) \land eats(X, honey)$$

<!--vert-->

#### rules

A **rule** is a statement which enables us to define new relationships in terms of existing ones:

```prolog
predicate(term1, ..., termN) :- goal1, ..., goalN.
```

<!--vert-->

`Y` is a survival dependency of `X` if:

* `X` eats `Y`
* or `X` eats `Z` and `Y` is a survival dependency of `Z`

```prolog
survival_dependency(X, Y) :- eats(X, Y).
survival_dependency(X, Y) :-
    eats(X, Z), survival_dependency(Z, Y).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" --> 

```prolog
?- survival_dependency(bear, X).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

---

### dynamically loading programs

Given a program in a file `prog.pl` we can load it into the REPL using `consult/1`:

```prolog
?- consult('prog.pl').
/* or */
?- consult(prog).
```

Also possible using brackets:

```prolog
?- [prog].
```

---

### matching

Two terms match if:

* They are identical.
* The variables in both terms can be instantiated to make the terms identical.

<!--vert-->

The `=` operator performs matching

```prolog
?- course(N, S, 95) = course(X, fall, G).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
?- course(N, S, 95) = course(Y, M, 96).

?- course(X) = semester(Y).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

### matching rules

Terms `S` and `T` match if:

* `S` and `T` are the same atom.
* `S` and `T` are the same number.
* If one is a variable which is instantiated to the other.
* If `S` and `T` are compound terms, they match iff:
  * They have the same functor and arity.
  * All their corresponding arguments match.
  * The variable instantiations are compatible.

<!--vert-->

### geometric example

Use compound terms to represent geometric shapes.

```prolog
point(1, 1)
seg( point(1, 1), point(2, 3) )
triangle( point(4, 2), point(6, 4), point(7, 1) )
```

<!--vert-->

### geometric example

```prolog
?- triangle(point(1, 1), A, point(2, 3))
=
triangle(X, point(4, Y), point(2, Z)).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

### matching as means of computation

Facts:

```prolog
vertical(seg(
    point(X, Y1),
    point(X, Y2)
)).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

Queries:

```prolog
?- vertical(seg(point(1, 1), point(1, 2))).

?- vertical(seg(point(1, 1), point(2, Y))).

?- vertical(seg(point(2,3), P)).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

---

### arithmetic operations

* The operators `+ - * / div mod` are (infix) binary relations.
* But they are considered arithmetic operators after the operator `is`.

```prolog
?- X = 1 + 2.

?- X is 1 + 2.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

### comparison operators

```prolog
X > Y
X < Y
X >= Y
X =< Y
X =:= Y  % equal
X =\= Y  % not equal
```

<!--vert-->

The comparison operators also force evaluation:

```prolog
?- 11 * 6 = 66.

?- 11 * 6 =:= 66.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

#### `=` VS. `=:=`

* `=` is used for matching and may instantiate variables.
* `=:=` causes an arithmetic evaluation of its operands and cannot instantiate variables.

```prolog
?- 1 + X = Y + 2.

?- 1 + X =:= Y + 2.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

#### Example - GCD

```prolog
gcd(X, X, X).
gcd(X, Y, D) :-
    X < Y,
    Y1 is Y - X,
    gcd(X, Y1, D).
gcd(X, Y, D) :-
    Y < X,
    gcd(Y, X, D).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
?- gcd(12, 30, D).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

---

### builtin control predicates

<!--vert-->

#### conjunction `,/2`

The goal `(G1, G2)` succeeds if `G1` and `G2` succeed.

<!--vert-->

#### disjunction `;/2`

The goal `(G1 ; G2)` succeeds if `G1` or `G2` succeed.

Defined as follows:

```prolog
(G1 ; G2) :- G1.
(G1 ; G2) :- G2.
```

<!--vert-->

#### true

The predicate `true/0` always succeeds.

<!--vert-->

#### false

The predicates `false/0` and `fail/0` always fail.

<!--vert-->

#### negation as failure

* The negation predicate is `\+/1`.
* It is not logical negation!
* For known predicates, prolog works under a closed world assumption - if something can't be proved then it is false.

<!--vert-->

```prolog
person(jimmy).
person(cindy).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
?- person(rick).
?- \+ person(rick).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

It might not work like you'd expect

```prolog
?- person(X).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
?- \+ person(X).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

Why doesn't prolog answer with `X = rick` or simply with `true`?

<!--vert-->

`person(X)` succeeds so its negation fails

* if `G` fails `\+ G` succeeds
* if `G` succeeds `\+ G` fails

<!--vert-->

`\+/1` allows for non-monotonic reasoning - a fact can become false by adding clauses to the database:

```prolog
illegal(murder).
legal(X) :- \+ illegal(X).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
illegal(theft).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
?- legal(theft).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

---

### exercise - family tree

Given a database with the following predicate:

```prolog
parent(X, Y).  % X is Y's parent
```

```prolog
% examples:
parent(adam, cain).
parent(eve, cain).
parent(cain, enoch).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

Define a predicate `grandparent(X)` that holds when `X` is a grandparent.

<!--vert-->

```prolog
...
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
?- grandparent(X).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
grandparent(X) :- parent(X, Y), parent(Y, _).
```

<!--vert-->

Define a predicate `nuclear(X, Y)` that holds when `X` and `Y` are in the same nuclear family.

A nuclear family (in our example) consists of 2 parents and their common children.

<!--vert-->

```prolog
...
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
?- nuclear(adam, X).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
nuclear(X, Y) :-  % siblings
    parent(P1, X), parent(P2, X),
    parent(P1, Y), parent(P2, Y),
    \+(P1 = P2).  % alternatively: `P1 \= P2`

nuclear(X, Y) :-
    parent(X, C), parent(Y, C).

nuclear(X, Y) :-
    (parent(X, Y); parent(Y, X)).
```

---

### exercise - binary trees

We represent binary trees as terms:

* `nil` is the empty tree.
* `node(N, Tl, Tr)` is a tree node where `N` is some number and `Tl` and `Tr` are binary trees.

Define a predicate `tree_size(T, S)` such that `T` is a binary tree and `S` is its size

<!--vert-->

```prolog
...
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
?- tree_size(node(1,
	node(2, 
		nil, 
		nil
	),
	node(3,
		node(4, nil, nil),
		nil
	)),
	S).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
tree_size(nil, 0).
tree_size(node(_, Tl, Tr), S) :-
    tree_size(Tl, Sl),
    tree_size(Tr, Sr),
    S is Sl + Sr + 1.
```

<!--vert-->

Define a predicate `tree_max(T, M)` such that `T` is a binary tree and `M` is the max of the values of `T`'s nodes.

You may use the arithmetic function `max/2`

```prolog
...
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
?- tree_max(node(10,
    node(-3, 
        nil, 
        nil
    ),
    node(14,
        node(4, nil, nil),
        nil
    )),
    M).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
tree_max(node(N, nil, nil), N).
tree_max(node(N, nil, Tr), M) :-
    tree_max(Tr, Mr), M is max(N, Mr).
tree_max(node(N, Tl, nil), M) :-
    tree_max(Tl, Ml), M is max(N, Ml).
tree_max(node(N, Tl, Tr), M) :-
    tree_max(Tl, Ml),
    tree_max(Tr, Mr),
    M is max(N, max(Ml, Mr)).
```

<!--vert-->

A perfect binary tree is a binary tree in which all interior nodes have two children and all leaves have the same depth. Also, the value of each interior node is equal to its depth.

Define a predicate `perfect_tree(T, H)` such that `T` is a perfect binary tree and `H` is its height.

<!--vert-->

```prolog
...
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

```prolog
?- perfect_tree(T, 2).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
perfect_tree(nil, 0).
perfect_tree(node(H, Tl, Tl), H) :-
    H > 0,
    H1 is H - 1,
    perfect_tree(Tl, H1).
```
