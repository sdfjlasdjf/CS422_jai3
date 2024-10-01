
// Exercise 1
kmodule LESSON-02-A

  syntax Color ::= Yellow() | Blue() | Black() | Green()
  syntax Fruit ::= Banana() | Blueberry() | Blackberry() | Kiwi()
  syntax Color ::= colorOf(Fruit) [function]

  rule colorOf(Banana()) => Yellow()
  rule colorOf(Blueberry()) => Blue()
  rule colorOf(Blackberry()) => Black()
  rule colorOf(Kiwi()) => Green()

endmodule

// Exercise 2
kmodule LESSON-02-OUTFIT

  syntax Color ::= Black() | White()
  syntax Boolean ::= true() | false()
  syntax Outfit ::= outfit(Color, Color, Color, Color)
  syntax Boolean ::= outfitMatching(Outfit) [function]

  rule outfitMatching(outfit(C, C, C, C)) => true()

endmodule
