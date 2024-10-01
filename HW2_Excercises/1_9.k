//Exercise 1:
module LESSON-09-C-COLORING
  imports BOOL

  syntax Stmt ::= "{" Stmt "}" [format(%n%1%n%i%2%n%d%3), color(green)] 
                | "{" "}" [format(%n%1%2%n), color(green)]
                > right:
                  Stmt Stmt [format(%1%n%2)]
                | "if" "(" Bool ")" Stmt [format(%1 %2%3%4%n%i%5%d), color(red)]
                | "if" "(" Bool ")" Stmt "else" Stmt [avoid, format(%1 %2%3%4%n%i%5%d%nelse%n%i%7%d), colors(red, blue)]

//Exercise 2
module LITERATE-CALCULATOR-COLOR
  imports INT
  imports BOOL

  syntax Int ::= Int "+" Int [function, color(blue)]
               | Int "-" Int [function, color(blue)]
               | Int "*" Int [function, color(blue)]
               | Int "/" Int [function, color(blue)]

  rule I1 + I2 => I1 +Int I2
  rule I1 - I2 => I1 -Int I2
  rule I1 * I2 => I1 *Int I2
  rule I1 / I2 => I1 /Int I2 requires I2 =/=Int 0
  rule I1 / I2 => 0 [owise]

  syntax Bool ::= Int "==" Int [function, color(red)]
                | Int "<"  Int [function, color(red)]
                | Int "<=" Int [function, color(red)]
                | Int ">"  Int [function, color(red)]
                | Int ">=" Int [function, color(red)]

  rule I1 == I2 => true  requires I1 -Int I2 ==Int 0
  rule I1 == I2 => false [owise]

  rule I1 < I2 => true  requires I2 -Int I1 >Int 0
  rule I1 < I2 => false [owise]

  rule I1 <= I2 => true  requires I1 < I2 orBool I1 == I2
  rule I1 <= I2 => false [owise]

  rule I1 > I2 => true  requires I2 < I1
  rule I1 > I2 => false [owise]

  rule I1 >= I2 => true  requires I1 > I2 orBool I1 == I2
  rule I1 >= I2 => false [owise]
endmodule
