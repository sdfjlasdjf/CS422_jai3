//Exercise 1

module LESSON-17-SOLUTION
  imports INT
  imports BOOL
  imports STRING
  imports ID
  imports MAP

  configuration <T>
                  <threads>
                    <function multiplicity="*" type="Map">
                      <name> "" </name>
                      <body> .K </body>
                    </function>
                  </threads>
                  <state> .Map </state>
                  <k> $PGM:Pgm </k>
                  <fstack> .List </fstack>
                </T>

  syntax Pgm ::= List{Decl, ""}
  syntax Decls ::= List{Decl, ""}
  syntax Decl ::= "int" Id "=" Exp ";" | "fun" Id "()" "{" Stmts "}"
  syntax Stmts ::= List{Stmt, ""}
  syntax Stmt ::= Exp ";" | Id "=" Exp ";" | "return" Exp ";"
  syntax Exp ::= Id "(" ")" | Int | "spawn" "{" Stmts "}" | "join" Exp ";"

  rule <k> D:Decl P:Pgm => D ~> P ...</k>
  rule <k> int X:Id = I:Int ; => . ...</k>
       <state> STATE => STATE [ X <- I ] </state>

  rule <k> fun F:Id () { S:Stmts } => . ...</k>
       <threads> FUNCS => FUNCS <function> <name> F </name> <body> S </body> </function> </threads>

  syntax KItem ::= stackFrame(K)
  rule <k> X:Id () ~> K => S </k>
       <threads>... <function> <name> X </name> <body> S </body> ...</threads>
       <fstack> .List => ListItem(stackFrame(K)) ...</fstack>

  rule <k> X:Id = I:Int ; => . ...</k>
       <state> STATE => STATE [ X <- I ] </state>

  rule <k> return I:Int ; ~> _ => I ~> K </k>
       <fstack> ListItem(stackFrame(K)) => .List ...</fstack>

  rule <k> spawn { Ss:Stmts } => NEXTID ...</k>
       <state> STATE => STATE [ "next-id" <- NEXTID ] </state>
       (.Bag => <function> <name> NEXTID </name> <body> Ss </body> </function>)

  rule <k> join ID:Int ; => I ...</k>
       <threads>... <function> <name> ID </name> <body> return I:Int ; </body> ...</threads>

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


