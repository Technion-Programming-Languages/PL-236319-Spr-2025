# Gradual Typing

---

### Type Safety\Soundness

The extent to which a programming language discourages or prevents type errors.

<!--vert-->

### Static Typing

Correctness of types is checked during compilation or before execution.

> Examples: C++, Java, SML

<!--vert-->

### Static Typing - Advantages

* Type errors are caught early.
* Typed code is easier to optimize.

<!--vert-->

### Static Typing - Disadvantages

* Less flexible
* Requires a compiler\type checker.

<!--vert-->

### Dynamic Typing

Correctness of types is checked during execution.

> Examples: JavaScript, Python

<!--vert-->

### Dynamic Typing - Advantages

* More flexible.
* In some sense easier to use.

<!--vert-->

### Dynamic Typing - Disadvantages

* Type errors are caught only during execution.
* Harder to scale and maintain.

---

### Motivation

Let's say we develop a simple social network, where users can post messages and comment on them.

We want to deploy our website as quickly as possible, therefore we use Ruby (which is a dynamically typed, interpreted languages) to implement our backend.

<!--vert-->

### Motivation

As our user base grows, it requires a more complex backend. However, it is getting harder and harder to maintain and scale our code base.

What should we do? Should we rewrite our backend in a statically typed language, let's say Scala?

> Side note - Based on a true story.

<!--vert-->

### Another Motivation

Let's say we develop a more complex web application. We would like to use static typing in order to catch errors early and make our application more maintainable.

However, browsers can only run JavaScript, and any library we would like to use is written in JavaScript as well.

<!--vert-->

### Another Motivation

Can we make our JavaScript code statically typed somehow?

---

### Gradual Typing - Definition

Correctness of types is checked either before or during execution.

<!--vert-->

### Example - TypeScript

TypeScript is a compiled, **gradually typed** language, which is a superset of JavaScript.

<!--vert-->

Conside the following JavaScript code:

```javascript
function add(a, b) {
    return a + b;
}

const result1 = add(5, 10);
const result2 = add("5", 10);

console.log(result1, result2);
```

What will be printed to the console?

<!--vert-->

Now let's "convert" it to TypeScript:

```typescript
function add(a: number, b: number): number {
    return a + b;
}

const result1 = add(5, 10);
const result2 = add("5", 10); /* Compilation Error */

console.log(result1, result2);
```

<!--vert-->

### Gradual Typing with Typescript

The `any` keyword can be used to disable type checking for a specific variable or function.

For example the following code will pass compilation:

```typescript
import * as lib from 'library_i_know_nothing_about'

const value: any = lib.returnSomeValue();

console.log(value);
```

<!--vert-->

### Typescript `any` vs `unknown`

While both `any` and `unknown` may be considered as "Top" types, there is a key difference - while `any` is not checked at all, `unknown` is checked at compile time:


```typescript
function foo(obj: any) {
    return obj.field; /* No compilation error */
}

function bar(obj: unknown) {
    return obj.field; /* Compilation error */
}

```
<!--vert-->

### Typescript unsoundness

Important Note! - TypeScript's type system is not sound, meaning that it is possible to write code that will pass compilation, but will cause type errors during execution.

```typescript
function foo(obj: any) {
    return obj.field; /* Will cause runtime type error! */
}

foo(2);
```
---

### Example - C#

C# is a compiled, statically typed programming language.

<!--vert-->

C# version 4.0 introduced the `dynamic` type, which is a type that bypasses compile-time type checking.

```csharp
static void Main(string[] args)
{
    dynamic MyVar = 100;
    Console.WriteLine("Value: {0}", MyVar);

    MyDynamicVar = "Hello World!!";
    Console.WriteLine("Value: {0}", MyVar);
}
```

<!--vert-->

### Example - Dart

Dart is a compiled, gradually typed language, that is compiled either to JavaScript or native code.

Dart supports `dynamic` type as well:

```dart
void main()
{
    dynamic a = 40;
    print(a);

    a= "Dart";
    print(a);
}

```
<!--vert-->

### Examples comparison

* TypeScript - Developed on top of a dynamically typed language in order to improve soundness.
* C# - Was originally a strictly statically typed language, but added a dynamic type in order to improve flexibility.
* Dart - Supports gradual typing from day 1.
---

## Gradual Typing Excercise

<!--vert-->

The TAs of PL class has argued whether SML is a gradually typed language or not.

Andrey claims that SML is a gradually typed language, since not all values must be annotated with types.

Is Andrey correct?

<!--vert-->

### Answer

Andrey is not correct.

SML is strictly statically typed. even though not all values must be annotated, their type must be inferred at **compile time**. Each value has a single concrete type that is known and being checked at compile time.

---

### Drawbacks of Gradual Typing

* Types might not be reliable or checked
* Ensuring type safety is expensive
