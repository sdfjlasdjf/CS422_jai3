// Exercise 1

We implement a function `concat` that takes a list of `String` elements and concatenates them together.

```k
module LESSON-12-STRING-CONCAT
  imports STRING

  syntax Strings ::= List{String, ","}

  // Function to concatenate a list of strings
  syntax String ::= concat(Strings) [function]
  rule concat(.Strings) => ""
  rule concat(S: String, Ss: Strings) => S +String concat(Ss)

endmodule


//Exercise 2
module LESSON-12-SUM-EMPTY
  imports INT

  syntax Ints ::= List{Int, ","}

  // Function to sum lists of integers, including empty lists
  syntax Int ::= sum(Ints) [function]
  rule sum(.Ints) => 0
  rule sum(I:Int) => I
  rule sum(I1:Int, I2:Int, Is:Ints) => sum(I1 +Int I2, Is)
endmodule

