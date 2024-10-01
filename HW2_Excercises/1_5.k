// Exercise 1
  syntax Int ::= r"([0-9]|[1-9][0-9]*)" [token]
               | "(" Int ")" [bracket]
endmodule

module ADD-SUB-NEG-SYNTAX
  imports INTEGERS-SYNTAX
  syntax Int ::= "-" Int [function]
               | Int "+" Int [left]
               | Int "-" Int [left]
endmodule

module MUL-DIV-SYNTAX
  imports INTEGERS-SYNTAX
  syntax Int ::= Int "*" Int [left]
               | Int "/" Int [left]
endmodule

module MAIN-SYNTAX
  imports ADD-SUB-NEG-SYNTAX
  imports MUL-DIV-SYNTAX
  syntax priority "*" "/" > "+" "-" > "-"
endmodule

module MAIN
  imports MAIN-SYNTAX
endmodule


// Exercise 2&3

module COLOR-SYNTAX
  syntax Color ::= Yellow() | Blue()
endmodule

module FRUIT-SYNTAX
  syntax Fruit ::= Banana() | Blueberry()
endmodule

module RULES
  imports COLOR-SYNTAX
  imports FRUIT-SYNTAX

  rule colorOf(Banana()) => Yellow()
  rule colorOf(Blueberry()) => Blue()
endmodule
