# Exercise 1


## Module for String Manipulation

```k
module LESSON-10-STRING
  imports STRING
  imports INT

  syntax String ::= constructSentence(String) [function]

  // Helper function to extract the first word of a sentence
  syntax String ::= firstWord(String) [function]
  rule firstWord(S) => substrString(S, 0, indexOfString(S, " ")) requires indexOfString(S, " ") >= 0
  rule firstWord(S) => S requires indexOfString(S, " ") < 0 // No space means it's a single word

  // Construct the new sentence from the first word of each sentence in the paragraph
  rule constructSentence(S) =>
    firstWord(S) +String ". " +String
    ( if lengthString(S) == indexOfString(S, ".") +Int 1
      then ""
      else constructSentence(substrString(S, indexOfString(S, ".") +Int 2, lengthString(S)))
    )
    requires indexOfString(S, ".") >= 0

endmodule
