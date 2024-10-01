//Exercise 1

```k
module LESSON-14-D-SUBTRACTION
  imports INT
  imports BOOL

  syntax Exp ::= Int
               | Bool
               > left: Exp "+" Exp [seqstrict]
               > left: Exp "&&" Exp [seqstrict]
               > left: Exp "-" Exp [seqstrict]

  rule <k> I1:Int + I2:Int => I1 +Int I2 ...</k>
  rule <k> I1:Int - I2:Int => I1 -Int I2 ...</k>
  rule <k> B1:Bool && B2:Bool => B1 andBool B2 ...</k>

  syntax Bool ::= isKResult(K) [function, symbol]
  rule isKResult(_:Int) => true
  rule isKResult(_:Bool) => true
  rule isKResult(_) => false [owise]
endmodule

//Exercise 2
module LESSON-14-D-DIVISION
  imports INT
  imports BOOL

  syntax Exp ::= Int
               | Bool
               > left: Exp "+" Exp [strict]
               > left: Exp "/" Exp [strict]
               > left: Exp "&&" Exp [seqstrict]

  rule <k> I1:Int + I2:Int => I1 +Int I2 ...</k>
  rule <k> I1:Int / I2:Int => I1 /Int I2 ...</k> requires I2 =/=Int 0
  rule <k> B1:Bool && B2:Bool => B1 andBool B2 ...</k>

  syntax Bool ::= isKResult(K) [function, symbol]
  rule isKResult(_:Int) => true
  rule isKResult(_:Bool) => true
  rule isKResult(_) => false [owise]
endmodule
