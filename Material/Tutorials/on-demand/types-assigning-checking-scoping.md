# Type Assigning, Checking, and Scoping

---

## Static & Dynamic Typing
- **Static Typing**: Type checking is done at compile time, and each variable and expression type is already known before the program runs
- **Dynamic Typing**: Type checking is performed at runtime, and variables typically do not have types fixed until they are assigned at runtime


---

## Strong & Weak Typing

- **Weak Typing**: Allows operations between different types without explicit conversion. For example, in JavaScript, you can add a string to a number without any issues
- **Strong Typing**: Requires explicit conversion between different types. For example, in Python, you cannot add a string to a number without converting one of them to the other type

---

## Strong & Weak Typing

These terms are often confused with Static and Dynamic Typing, but they are different concepts.
There also isn't a universal definition, and languages may fall somewhere in between these two extremes.

---

## Static & Dynamic Scoping

- **Static Scoping (Lexical Scoping)**: The scope of a variable is determined at compile time based on the structure of the code. This is the most common scoping rule.
- **Dynamic Scoping**: The scope of a variable is determined at runtime based on the calling sequence of functions, i.e., the scope can change depending on the function call sequence.

---

## Combinations

---

## Strong Typing with Static Typing
- Example Languages: ML, Pascal, Java
- Effects: Provides a high level of type safety, catching errors at compile time. This can lead to more robust and maintainable code but requires more upfront definition and less flexibility in terms of type manipulation at runtime.

---

## Strong Typing with Static Typing

```sml
fun add (x : int, y : int) : int = x + y

val result = add(5, 3) (* This will compile because the types are correct *)
val error = add(5, "hello") (* This will cause a compile-time error due to type mismatch *)
```
---

## Strong Typing with Dynamic Typing
- Example Languages: Python, Ruby
- Effects: Errors related to types are still caught, but they are typically found at runtime rather than compile time. This allows more flexibility in how functions and data structures are used but can lead to runtime exceptions if type issues are not properly managed.

---

## Strong Typing with Dynamic Typing

```python
def add_numbers(a, b):
    return a + b

result = add_numbers(10, "5")  # This will raise a TypeError at runtime
```
---

## 	Weak Typing with Static Typing
- Example Languages: C, Common Lisp
- Effects: The language allows more implicit type conversions at compile time, which can potentially lead to less predictable behavior and subtle bugs. However, it provides some level of type checking during compilation that can catch some errors early.

---

## 	Weak Typing with Static Typing

```c
#include <stdio.h>

int main() {
    int a = 10;
    float b = 5.5;
    printf("%f\n", a + b);  // This will compile and run
    return 0;
}
```
---

## 	Weak Typing with Dynamic Typing

![alt text](https://imageproxyb.ifunny.co/crop:x-20,resize:640x,quality:90x75/images/ad766d5f653ec01752126234c6f9c4ce8b7404f681a0958fd10f24b0cac9f212_1.jpg)

---

## 	Weak Typing with Dynamic Typing

- Example Languages: Pure Lisp, Prolog, JavaScript, PHP
- Effects: Maximum flexibility and ease of use, allowing rapid development and prototyping. However, this can also lead to more frequent runtime errors and less predictable behavior, as incorrect type usage might only become evident during execution.

---

## 	Weak Typing with Dynamic Typing

```javascript
function add(a, b) {
    return a + b;
}

let result = add(10, "5");  // This will concatenate the strings
console.log(result); // "105"
```

---

## Bonus: Compiled vs. Interpreted

- **Compiled Languages**: The source code is translated into machine code before execution. This typically results in faster execution but requires a compilation step before running the program
- **Interpreted Languages**: The source code is executed line by line, typically by an interpreter. This allows for more dynamic behavior but can be slower than compiled code

These concepts are distinct from typing methodologies, focusing instead on execution mechanisms.
