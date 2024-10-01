// Exercise 1

module LESSON-06-A
  imports BOOL

  syntax Fruit ::= Blueberry() | Banana() | Kiwi()
  syntax Bool ::= isBlue(Fruit) [function]
                | isYellow(Fruit) [function]
                | isBlueAndNotYellow(Fruit) [function]

  rule isBlue(Blueberry()) => true
  rule isBlue(Banana()) => false
  rule isBlue(Kiwi()) => true

  rule isYellow(Banana()) => true
  rule isYellow(Blueberry()) => false
  rule isYellow(Kiwi()) => true

  rule isBlueAndNotYellow(F) => isBlue(F) andBool notBool isYellow(F)
endmodule

// Test cases for isBlueAndNotYellow:
// krun -cPGM='isBlueAndNotYellow(Banana())' // Expected: false
// krun -cPGM='isBlueAndNotYellow(Blueberry())' // Expected: true
// krun -cPGM='isBlueAndNotYellow(Kiwi())' // Expected: false


// Exercise 2

module INTEGERS-SYNTAX
  // This module contains the syntax for integers and brackets.
  syntax Int ::= r"([0-9]|[1-9][0-9]*)" [token]
               | "(" Int ")" [bracket]
endmodule

module ADD-SUB-NEG-SYNTAX
  // This module contains the syntax for addition, subtraction, and negation.
  imports INTEGERS-SYNTAX
  syntax Int ::= "-" Int [function]
               | Int "+" Int [left]
               | Int "-" Int [left]
endmodule

module MUL-DIV-SYNTAX
  // This module contains the syntax for multiplication and division.
  imports INTEGERS-SYNTAX
  syntax Int ::= Int "*" Int [left]
               | Int "/" Int [left]
               | Int "div" Int [left]
endmodule

module MAIN-SYNTAX
  // The main module that imports other syntax modules and declares priorities.
  imports ADD-SUB-NEG-SYNTAX
  imports MUL-DIV-SYNTAX
  syntax priority "*" "/" > "+" "-" > "-"
endmodule

module BOOL-EXPRESSIONS-SYNTAX
  // This module contains the syntax for Boolean expressions and implications.
  imports BOOL-SYNTAX

  syntax Bool ::= "(" Bool ")" [bracket]
                > "!" Bool [function]
                > left: Bool "&&" Bool [function]
                | Bool "^" Bool [function]
                | Bool "||" Bool [function]
                | Bool "->" Bool [function]   // Implication operator
endmodule

module BOOL-EXPRESSIONS
  // This module imports the syntax and defines Boolean operations.
  imports BOOL-EXPRESSIONS-SYNTAX
  imports BOOL

  rule ! B => notBool B
  rule A && B => A andBool B
  rule A ^ B => A xorBool B
  rule A || B => A orBool B
  rule A -> B => impliesBool(A, B)
endmodule

module MAIN
  // The main module that imports integer and Boolean operations and implements them.
  imports MAIN-SYNTAX
  imports BOOL-EXPRESSIONS

  // Rules for Integer arithmetic
  rule I1 + I2 => I1 +Int I2
  rule I1 - I2 => I1 -Int I2
  rule I1 * I2 => I1 *Int I2
  rule I1 / I2 => I1 /Int I2 // Division without handling zero yet

  // Rules for comparison operators
  syntax Bool ::= Int "<" Int [function]
                | Int "<=" Int [function]
                | Int ">" Int [function]
                | Int ">=" Int [function]
                | Int "==" Int [function]
                | Int "!=" Int [function]

  rule I1 < I2  => I1 <Int I2
  rule I1 <= I2 => I1 <=Int I2
  rule I1 > I2  => I1 >Int I2
  rule I1 >= I2 => I1 >=Int I2
  rule I1 == I2 => I1 ==Int I2
  rule I1 != I2 => I1 =/=Int I2
endmodule


// Exercise 3: 

module DIVISION-EXAMPLES
  imports MAIN

  // Test cases for division behavior:
  // krun -cPGM='7 / 3' // With /Int: Expected 2, With divInt: Expected 2
  // krun -cPGM='7 / -3' // With /Int: Expected -2, With divInt: Expected -3
  // krun -cPGM='-7 / 3' // With /Int: Expected -2, With divInt: Expected -3
  // krun -cPGM='-7 / -3' // With /Int: Expected 2, With divInt: Expected 2
endmodule
