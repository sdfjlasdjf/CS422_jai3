//Exercise 1
module LESSON-18-SOLUTION
  imports INT
  imports BOOL
  imports K-EQUAL
  imports ID-SYNTAX

  configuration <T>
                  <state> .Map </state>
                  <k> $PGM:Pgm </k>
                </T>

  syntax Int ::= compareTerms(K, K) [function]
  rule compareTerms(X:K, Y:K) => #if X ==K Y #then 0 #else 1 #fi

  syntax Pgm ::= List{Decl, ""}
  syntax Decls ::= List{Decl, ""}
  syntax Decl ::= "int" Id "=" Exp ";" | "fun" Id "()" "{" Stmts "}"
  syntax Stmts ::= List{Stmt, ""}
  syntax Stmt ::= Exp ";" | Id "=" Exp ";" | "return" Exp ";" | "if" "(" Exp ")" Stmts "else" Stmts
  syntax Exp ::= Id "(" ")" | Int | Bool | Exp "+" Exp [seqstrict]

  rule <k> D:Decl P:Pgm => D ~> P ...</k>
  rule <k> int X:Id = I:Int ; => . ...</k>
       <state> STATE => STATE [ X <- I ] </state>

  rule <k> X:Id => I:Int ...</k>
       <state>... X |-> I ...</state>

  rule <k> fun F:Id () { S:Stmts } => . ...</k>
  rule <k> X:Id () ~> K => S ...</k>

  rule <k> I1:Int + I2:Int => I1 +Int I2 ...</k>

  rule <k> return I:Int ; ~> _ => I ...</k>

  rule <k> if (B:Bool) S1:Stmts else S2:Stmts => #if B #then S1 #else S2 #fi ...</k>

  syntax Bool ::= isKResult(K) [function, symbol]
  rule isKResult(_:Int) => true
  rule isKResult(_:Bool) => true
  rule isKResult(_) => false [owise]

endmodule

