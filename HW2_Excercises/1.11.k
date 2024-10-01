

// Exercise 1


```k
module LESSON-11-STRING-EVAL
  imports INT
  imports BOOL
  imports STRING

  syntax Exp ::= Int | Bool | String | Exp "+" Exp | Exp "&&" Exp | Exp "." Exp

  syntax Exp ::= eval(Exp) [function]
  
  rule eval(I:Int) => I
  rule eval(B:Bool) => B
  
  rule eval(S:String) => S
  rule eval(E1 . E2) => {eval(E1)}:>String +String {eval(E2)}:>String

  rule eval(E1 + E2) => {eval(E1)}:>Int +Int {eval(E2)}:>Int
  rule eval(E1 && E2) => {eval(E1)}:>Bool andBool {eval(E2)}:>Bool
endmodule

//Exercise 2
module LESSON-11-EVAL
  imports INT
  imports BOOL
  imports STRING

  syntax Exp ::= Int | Bool | String
               | Exp "+" Exp
               | Exp "-" Exp
               | Exp "*" Exp
               | Exp "/" Exp
               | Exp "==" Exp
               | Exp "<" Exp
               | Exp "<=" Exp
               | Exp ">" Exp
               | Exp ">=" Exp
               | Exp "&&" Exp
               | Exp "." Exp

  syntax Exp ::= eval(Exp) [function]

  // Evaluation rules for Int, Bool, and String
  rule eval(I:Int) => I
  rule eval(B:Bool) => B
  rule eval(S:String) => S

  // Arithmetic operations
  rule eval(E1 + E2) => {eval(E1)}:>Int +Int {eval(E2)}:>Int
  rule eval(E1 - E2) => {eval(E1)}:>Int -Int {eval(E2)}:>Int
  rule eval(E1 * E2) => {eval(E1)}:>Int *Int {eval(E2)}:>Int
  rule eval(E1 / E2) => {eval(E1)}:>Int /Int {eval(E2)}:>Int requires {eval(E2)} =/=Int 0
  rule eval(E1 / E2) => 0 [owise]

  // Boolean operations
  rule eval(E1 && E2) => {eval(E1)}:>Bool andBool {eval(E2)}:>Bool

  // Comparison operations
  rule eval(E1 == E2) => {eval(E1)}:>Int ==Int {eval(E2)}:>Int
  rule eval(E1 < E2)  => {eval(E1)}:>Int <Int {eval(E2)}:>Int
  rule eval(E1 <= E2) => {eval(E1)}:>Int <=Int {eval(E2)}:>Int
  rule eval(E1 > E2)  => {eval(E1)}:>Int >Int {eval(E2)}:>Int
  rule eval(E1 >= E2) => {eval(E1)}:>Int >=Int {eval(E2)}:>Int

  rule eval(E1 . E2) => {eval(E1)}:>String +String {eval(E2)}:>String
endmodule
