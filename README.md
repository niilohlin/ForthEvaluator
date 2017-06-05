# ForthEvaluator
Yet another toy language written in haskell. Inspired by Forth and Lisp.

# Basic Types
```
1 // Int
"string" // String
0.5 // Double
(1 2 3 * + -) // Lambda
'x // Symbol
x // Word
```

# Basic Syntax
```
1 2 + // -> 4

5 'x def // -> set "x" to 5

(1 +) 'succ def // Define the 'function' "succ"

"Hello world" print // print 'hello world'

(2 *) // add the 'lambda' (2 *) to the stack.

```

# Other Syntax
```
5 (2 +) eval // 7
"string" (1 2) (+) apply // "string" (3)
(1 2) (3) apply // (3 1 2)
(1 2) (drop) apply // (2)
(1 2) drop // -> empty
1 5 apply // -> (1 5)
(3 4) eval // -> 3 4
```

So `1 5 (+) eval` is equal to `1 5 +`. And `apply` executes the stack on the next stack item

# Concept
The language has two paralell stacks. One "data stack" and one "program stack". When the program is parsed. The entire program is added
to the program stack. And the data stack is empty. Anything that is evaluated from the program stack is automatically added to the data stack.
