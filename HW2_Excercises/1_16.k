
//Exercise 1
module LESSON-16-SOLUTION
  imports INT
  imports BOOL
  imports STRING
  imports ID
  imports MAP
  imports LIST

  configuration <T>
                  <k> $PGM:Pgm </k>
                  <state> .Map </state>
                  <functions> .Map </functions>
                  <fstack> .List </fstack>
                </T>

  syntax Pgm ::= List{Decl, ""}
  syntax Decls ::= List{Decl, ""}
  syntax Decl ::= "int" Id "=" Exp ";" | "fun" Id "()" "{" Stmts "}"
  syntax Stmts ::= List{Stmt, ""}
  syntax Stmt ::= Exp ";" | Id "=" Exp ";" | "return" Exp ";"
  syntax Exp ::= Id "(" ")" | Int

  rule <k> D:Decl P:Pgm => D ~> P ...</k>
  rule <k> int X:Id = I:Int ; => . ...</k>
       <state> STATE => STATE [ X <- I ] </state>
  rule <k> fun F:Id () { S:Stmts } => . ...</k>
       <functions> FUNCS => FUNCS [ F <- S ] </functions>

  // Function calls and assignments
  syntax KItem ::= stackFrame(K)
  rule <k> X:Id () ~> K => S </k>
       <functions>... X |-> S ...</functions>
       <fstack> .List => ListItem(stackFrame(K)) ...</fstack>

  rule <k> X:Id = I:Int ; => . ...</k>
       <state> STATE => STATE [ X <- I ] </state>

  // Return statement
  rule <k> return I:Int ; ~> _ => I ~> K </k>
       <fstack> ListItem(stackFrame(K)) => .List ...</fstack>

  syntax String ::= printStackTrace(List) [function]
  rule printStackTrace(.List) => "No active function calls.\n"
  rule printStackTrace(ListItem(stackFrame(K)) L:List) => "In function: " +String printStackTrace(L)

  // Variable and function lookups
  rule <k> X:Id => I ...</k>
       <state>... X |-> I ...</state>

  syntax Bool ::= isKResult(K) [function, symbol]
  rule isKResult(_:Int) => true
  rule isKResult(_:String) => true
  rule isKResult(_) => false [owise]
endmodule

module TEST-PROGRAM
  imports LESSON-16-SOLUTION

  syntax Pgm ::= "fun main() { return 5; }"
  syntax Stmt ::= "reset" ";" Exp

  configuration <T>
                  <k> $PGM:Pgm </k>
                  <state> .Map </state>
                </T>

endmodule
