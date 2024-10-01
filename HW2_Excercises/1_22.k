
module LESSON-22-SPEC-SYNTAX
    imports LESSON-22-SYNTAX
    syntax Id ::= "$a" [token]
    syntax Id ::= "$b" [token]
    syntax Id ::= "$c" [token]
    syntax Id ::= "$s" [token]
    syntax Id ::= "$n" [token]
    syntax Int ::= maxInt(Int, Int) 
endmodule

module VERIFICATION
    imports K-EQUAL
    imports LESSON-22-SPEC-SYNTAX
    imports LESSON-22
    imports MAP-SYMBOLIC

    rule { M:Map [ K <- V ] #Equals M [ K <- V' ] } => { V #Equals V' } [simplification]

    // Simplification rules for maxInt
    rule maxInt(A:Int, B:Int) => A requires A >=Int B [simplification]
    rule maxInt(A:Int, B:Int) => B requires B >Int A [simplification]

endmodule

module LESSON-22-SPEC
    imports VERIFICATION

    // Exercise 1
    claim <k> if ( 3 + 4 != 7 ) {
                $a = 1 ;
                } else {
                $a = 2 ;
                }
            => . ... </k>
            <store> STORE => STORE [ $a <- 2 ] </store>

    // Exercise 2
    claim <k> $a = A:Int ; $b = B:Int ;
              if ($a < $b) {
                $c = $b ;
              } else {
                $c = $a ;
              }
            => . ... </k>
            <store> STORE => STORE [ $a <- A ] [ $b <- B ] [ $c <- ?C:Int ] </store>
        ensures ?C ==Int maxInt(A, B)

    // Exercise 3
    claim <k> while ( 0 < $b ) {
                $a = $a + $c;
                $b = $b - 1;
                $c = $c - 1;
              } => . ... </k>
        <store> $a |-> (A:Int => A +Int ((B *Int (2 *Int C +Int 1)) /Int 2)) 
                $b |-> 0 
                $c |-> (C:Int => C -Int B) </store>
        requires B >=Int 0

    // Exercise 4
    syntax Exp ::= "multiply" "(" Exp "," Exp ")" [strict(2)]

    rule <k> multiply(0, _) => 0 ... </k>
    rule <k> multiply(N:Int, M:Int) => M +Int multiply(N -Int 1, M) 
         requires N >Int 0 ... </k>

    claim <k> $result = multiply(N:Int, M:Int) => . ... </k>
        <store> $result |-> (R:Int => N *Int M) </store>
        requires N >=Int 0

endmodule
