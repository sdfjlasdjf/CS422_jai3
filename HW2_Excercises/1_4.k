module LESSON-1-4-EXERCISES

// Exercise 1
syntax Boolean ::= "true" | "false"
                 | "(" Boolean ")" [bracket]
                 > "!" Boolean [function]
                 > Boolean "&&" Boolean [function, avoid]  // Modified to avoid the default parse.
                 > Boolean "||" Boolean [function]

endmodule

// Exercise 2
// Left associativity for binary operators.
module LESSON-1-4-EXERCISE-2

syntax Exp ::= "-" Exp [function]
             | Exp "*" Exp [left]
             | Exp "/" Exp [left]
             | Exp "+" Exp [left]
             | Exp "-" Exp [left]

endmodule

// Inline version of Exercise 2
module LESSON-1-4-EXERCISE-2-INLINE

syntax Exp ::= "-" Exp [function]
             > left: Exp "*" Exp [left]
             | Exp "/" Exp [left]
             | Exp "+" Exp [left]
             | Exp "-" Exp [left]

endmodule

// Exercise 3
module LESSON-1-4-EXERCISE-3

syntax Stmt ::= "while" "(" Boolean ")" Stmt [prefer]
              | "if" "(" Boolean ")" Stmt
              | "{" "}"

endmodule

// Exercise 4
module EXERCISE4

syntax Expr ::= "a" Expr "b"
              | "abb"
              | "b"

endmodule

// The parser doesn't recognize the ambiguity because the production of "abb" doesn't conflict with the recursive production of "a Expr b". 
// To induce ambiguity, the two productions can be made more structurally similar or an explicit ambiguity rule can be introduced.

endmodule
