
//Exercise 1
module LESSON-15-C
  imports INT
  imports BOOL

  configuration <T>
                  <k> $PGM:Exp </k>
                  <state>
                    <divConfig> false </divConfig>
                  </state>
                </T>

  syntax Exp ::= Int
               | Exp "+" Exp [seqstrict]
               | Exp "/" Exp [seqstrict]

  syntax Stmt ::= Bool ";" Exp | "reset" ";" Exp

  rule <k> true ; E:Exp => E ...</k>
       <divConfig> _ => true </divConfig>

  rule <k> false ; E:Exp => E ...</k>
       <divConfig> _ => false </divConfig>

  rule <k> reset ; E:Exp => E ...</k>
       <divConfig> ... </divConfig>

  rule <k> I1:Int / I2:Int => I1 /Int I2 ...</k> requires $DIVCONFIG ==Bool true
  rule <k> I1:Int / I2:Int => I1 divInt I2 ...</k> requires $DIVCONFIG ==Bool false
  rule <k> I1:Int + I2:Int => I1 +Int I2 ...</k>

  syntax Bool ::= isKResult(K) [function, symbol]
  rule isKResult(_:Int) => true
  rule isKResult(_) => false [owise]
endmodule
