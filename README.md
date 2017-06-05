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

# Concept
The language has two paralell stacks. One "data stack" and one "program stack". When the program is parsed. The entire program is added
to the program stack. And the data stack is empty. Anything that is evaluated from the program stack is automatically added to the data stack.
