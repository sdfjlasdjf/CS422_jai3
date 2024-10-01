//Exercise 1

module LESSON-02
    imports BOOL
    imports INT

    syntax Nat ::= "0"              [token]
                 | "S" "(" Nat ")"  [token]

    syntax Nat ::= sum(Nat, Nat) [macro]
    rule sum(0, N) => N
    rule sum(S(N1), N2) => S(sum(N1, N2))

    syntax Stmt ::= "if" "(" Exp ")" Stmt             [alias]
                  | "if" "(" Exp ")" Stmt "else" Stmt
                  | "{" Stmts "}"
    syntax Stmts ::= List{Stmt,""}
    syntax Exp ::= Bool

    rule if ( E ) S => if ( E ) S else { .Stmts }

    syntax Exp ::= Exp "+" Exp
                 | Exp "-" Exp
                 | Exp "*" Exp
                 | Exp "/" Exp

    syntax KItem ::= val(Int) [symbol]
    
    rule <k> I1:Int + I2:Int => I1 +Int I2 ... </k>
    rule <k> I1:Int - I2:Int => I1 -Int I2 ... </k>
    rule <k> I1:Int * I2:Int => I1 *Int I2 ... </k>
    rule <k> I1:Int / I2:Int => I1 /Int I2 ... </k>

    rule anywhere E1:Exp + E2:Exp => E1 +Int E2
    rule anywhere E1:Exp - E2:Exp => E1 -Int E2
    rule anywhere E1:Exp * E2:Exp => E1 *Int E2
    rule anywhere E1:Exp / E2:Exp => E1 /Int E2

endmodule
