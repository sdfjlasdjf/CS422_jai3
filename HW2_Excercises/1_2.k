// Exercise 1
kmodule LESSON-03-D

  syntax Boolean ::= "true" | "false"
                   | "(" Boolean ")" [bracket]
                   | "!" Boolean [function]
                   | Boolean "&&" Boolean [function]
                   | Boolean "^" Boolean [function]
                   | Boolean "||" Boolean [function]

endmodule

// Exercise 2
kmodule LESSON-03-E

  syntax Int ::= r"[0-9]+" [token]
  syntax Exp ::= Int
               | "(" Exp ")" [bracket]
               | "-" Exp [function]
               | Exp "+" Exp [function]
               | Exp "-" Exp [function]
               | Exp "*" Exp [function]
               | Exp "/" Exp [function]

endmodule

// Exercise 3
// Ambiguous example: 5 - 3 + 2
// Disambiguated versions:
kmodule LESSON-03-F

  syntax Int ::= r"[0-9]+" [token]
  syntax Exp ::= Int
               | "(" Exp ")" [bracket]
               | "-" Exp [function]
               | Exp "+" Exp [function]
               | Exp "-" Exp [function]
               | Exp "*" Exp [function]
               | Exp "/" Exp [function]

  rule evalExp(5 - 3 + 2) => evalExp((5 - 3) + 2)

  rule evalExp(5 - (3 + 2)) => evalExp(5 - (3 + 2))

endmodule
