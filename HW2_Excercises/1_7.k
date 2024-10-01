// Exercise 1

module IS-EVEN
  imports BOOL
  imports INT

  syntax Bool ::= isEven(Int) [function]

  // Rule for even numbers
  rule isEven(I) => true  requires I modInt 2 ==Int 0

  // Rule for odd numbers (owise)
  rule isEven(_) => false [owise]

endmodule

// Test cases for isEven:
// krun -cPGM='isEven(4)'  // Expected: true
// krun -cPGM='isEven(5)'  // Expected: false


// Exercise 2

module DIVISION-HANDLING
  imports MAIN-SYNTAX
  imports BOOL
  imports INT

  // Redefine the /Int operation with division by zero handling
  syntax Int ::= Int "/" Int [function]

  rule I1 / I2 => I1 /Int I2 requires I2 =/=Int 0
  rule I1 / I2 => 0 [owise] // Return 0 when dividing by zero

endmodule

// Test cases for division handling:
// krun -cPGM='4 / 2'  // Expected: 2
// krun -cPGM='4 / 0'  // Expected: 0 (Handled division by zero)


// Exercise 3

module CUSTOM-COMPARISONS
  imports INT
  imports BOOL

  syntax Bool ::= Int "==" Int [function]
                | Int "<"  Int [function]
                | Int "<=" Int [function]
                | Int ">"  Int [function]
                | Int ">=" Int [function]

  // Equality: Two numbers are equal if their difference is zero
  rule I1 == I2 => true  requires I1 -Int I2 ==Int 0
  rule I1 == I2 => false [owise]

  // Less than: I1 is less than I2 if (I2 - I1) is positive
  rule I1 < I2 => true  requires I2 -Int I1 >Int 0
  rule I1 < I2 => false [owise]

  // Less than or equal: True if I1 < I2 or I1 == I2
  rule I1 <= I2 => true  requires I1 < I2 orBool I1 == I2
  rule I1 <= I2 => false [owise]

  // Greater than: True if I2 < I1
  rule I1 > I2 => true  requires I2 < I1
  rule I1 > I2 => false [owise]

  // Greater than or equal: True if I1 > I2 or I1 == I2
  rule I1 >= I2 => true  requires I1 > I2 orBool I1 == I2
  rule I1 >= I2 => false [owise]

endmodule

// Test cases for custom comparison functions:
// krun -cPGM='4 == 4'  // Expected: true
// krun -cPGM='4 == 5'  // Expected: false
// krun -cPGM='3 < 5'   // Expected: true
// krun -cPGM='5 < 3'   // Expected: false
// krun -cPGM='3 <= 3'  // Expected: true
// krun -cPGM='3 >= 4'  // Expected: false


// Modifying calculator with custom comparison functions from Exercise 2
module CUSTOM-CALCULATOR
  imports CUSTOM-COMPARISONS
  imports MAIN

  // Now the calculator will use custom comparison operators instead of built-in ones.
endmodule

// Test cases for CUSTOM-CALCULATOR:
// krun -cPGM='5 <= 5'   // Expected: true
// krun -cPGM='10 > 15'  // Expected: false
// krun -cPGM='20 / 0'   // Expected: 0 (Handled division by zero)

