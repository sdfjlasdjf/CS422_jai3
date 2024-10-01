//Exercise 1
module LESSON-21
    imports INT

    // Rule 1: Rewriting 0 to a symbolic integer that isn't 0
    rule <k> 0 => ?X:Int ... </k> ensures ?X =/=Int 0

    // Rule 2: Rewriting integers greater than or equal to 10 to 5
    rule <k> X:Int => 5  ... </k> requires X >=Int 10

    // Rule 3: Rewriting odd integers greater than 10 to a symbolic even integer between 1 and 9
    rule <k> X:Int => ?Y:Int ... </k>
         requires X >Int 10 andBool X %Int 2 =/=Int 0
         ensures ?Y >Int 0 andBool ?Y <Int 10 andBool ?Y %Int 2 ==Int 0
endmodule

//First Rule Applies: The initial state of 0 is rewritten to a symbolic integer ?X, with the condition that ?X =/= 0. This creates a symbolic configuration where ?X can be any integer except zero.
//Second Rule May Apply: If ?X >= 10, the second rule can apply, rewriting ?X to 5.
//New Rule Applies Nondeterministically: If ?X > 10 and ?X is odd, the third rule will apply, rewriting ?X to a symbolic even integer ?Y between 1 and 9.
