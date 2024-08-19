# prolog

## exam questions

---

### question 1

<!--vert-->

#### question 1.1

write rules for the predicate `interleave/2` such that `interleave(L, R)` is true if `L` is a list of lists and `R` is the lists in `L` interleaved.

* you may assume that `L` is a concrete list of lists
* example: `interleave([[p,l],[r,o],[o,g]], [p,r,o,l,o,g])`

<!--vert-->

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
interleave([], []).
interleave([[]|X], R) :- interleave(X, R).
interleave([[X|Xs]|Ys], [X|R]) :-
    append(Ys, [Xs], Z),
    interleave(Z, R).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

#### question 1.2

the predicates `cond1/1` and `cond2/1` take a concrete integer. implement `filter/2` such that `filter(Xs, Ys)` is true if `Xs` is a list of integers and `Ys` is a list of all integers from `Xs` for which `cond1` is true and `cond2` is false.

* you may assume `Xs` is a concrete list of integers

<!--vert-->

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
filter([], []).
filter([X|Xs], [X|R]) :-
    cond1(X), \+ cond2(X), filter(Xs, R), !.
filter([X|Xs], R) :- filter(Xs, R).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

---

### question 2

<!--vert-->

#### question 2.1

implement `dec_bin/2` such that `dec_bin(D, B)` is true if `B` is the binary representation of `D`. (`D` is concrete)

example:

```prolog
?- dec_bin(12, K).
% K = '1100'.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

(you may use `atom_concat/3` - `atom_concat(A, B, R)` holds if `A`, `B` and `R` are atoms and `R = concat(A, B)`)

<!--vert-->

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
dec_bin(0, '0') :- !.
dec_bin(1, '1') :- !.
dec_bin(N, B) :-
    X is N mod 2, Y is N // 2,
    dec_bin(Y, H),
    atom_concat(H, X, B)
.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

#### question 2.2

implement `bin_dec/2`.

example:

```prolog
?- bin_dec('1100', K).
% K = 12.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
bin_dec('0', 0) :- !.
bin_dec('1', 1) :- !.
bin_dec(B, N) :- atom_concat(A, '1', B), !, bin_dec(A, N1), N is 2 * N1 + 1.
bin_dec(B, N) :- atom_concat(A, '0', B), !, bin_dec(A, N1), N is 2 * N1.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

---

### question 3

implement `mergeSort/2`.

```prolog
?- mergeSort([56, 29, 35, 42, 15, 41, 75, 21], R).
% R = [15, 21, 29, 35, 41, 42, 56, 75].
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

let's implement `merge/3` first:

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
merge(L, [], L).
merge([], L, L).
merge([X|Xs], [Y|Ys], [X|R]) :- X =< Y, merge(Xs, [Y|Ys], R), !.
merge(Xs, Ys, R) :- merge(Ys, Xs, R).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
mergeSort([], []) :- !.
mergeSort([A], [A]) :- !.
mergeSort(L, R) :-
    length(L, N),
    NL is N // 2, NR is N - NL,
    length(LL, NL), length(LR, NR),
    append(LL, LR, L),
    mergeSort(LL, LLS),
    mergeSort(LR, LRS),
    merge(LLS, LRS, R).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

---

### question 4

the predicate `edge/3` defines a weighted graph.

`edge(X,Y,N)` is true if there's an edge from `X` to `Y` with weight `N`.

define `path/4`. `path(X,Y,P,N)` is true if `P` is a path from `X` to `Y` with weight `N`.

```prolog
edge(a, b, 2).
?- path(a, b, P, N).
% P = [a, b], N = 2.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
path(X, X, [X], 0).
path(X, Y, [X|P], N) :-
    edge(X, Z, N1),
    path(Z, Y, P, N2),
    N is N1 + N2.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

define `cycle/1`. `cycle(X)` is true if there's a cycle that goes through `X`.

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
cycle(X) :- path(X, X, P, _), length(P, N), N > 1.
% or
cycle(X) :- edge(Y, X), path(X, Y, _, _).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

---

### question 5

how can a knight jump on an NxN chessboard in such a way that it visits every square exactly once?

<!--vert-->

```prolog
jump_dist(1, 2).
jump_dist(2, 1).
jump_dist(2, -1).
jump_dist(1, -2).
jump_dist(-1, -2).
jump_dist(-2, -1).
jump_dist(-2, 1).
jump_dist(-1, 2).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

define `jump(N, A/B, C/D)` such that there's a jump from `A/B` to `C/D` on an NxN board

* `A/B` are concrete

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
jump(N, A/B, C/D) :- 
   jump_dist(X, Y), 
   C is A + X, C > 0, C =< N,
   D is B + Y, D > 0, D =< N.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

define `knights(N,Ks)` such that `Ks` is a valid knight's tour on an NxN chessboard

```prolog
?- knights(5, Ks) {1}.
% Ks = [1/5, 3/4, 5/5, 4/3, 5/1, 3/2, 1/3, 2/5, 4/4, 5/2, 3/1, 1/2,
% 2/4, 4/5, 5/3, 4/1, 2/2, 1/4, 3/3, 2/1, 4/2, 5/4, 3/5, 2/3, 1/1].

?- knights(4, Ks).
% false.
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->

<!--vert-->

```prolog
:- use_module(library(clpfd)).
knights(N, Knights) :-
    X in 1..N, Y in 1..N, label([X, Y]), M is N * N - 1, knights(N, M, [X/Y], Knights).
knights(_, 0, Knights, Knights).
knights(N, M, Visited, Knights) :-
   Visited = [X/Y|_],
   jump(N, X/Y, U/V),
   \+ member(U/V, Visited),
   M1 is M - 1,
   knights(N, M1, [U/V|Visited], Knights).
```
<!-- .element: data-thebe-executable-prolog data-language="text/x-prolog" -->
