# Overview

A simple interpreter for a simple language.

# Lexer

At its core is a scanner whose job is to advance through the source code one
character at a time. It will:

- take in a string of characters that consists of the entire file to be
  scanned.
- report the `position` of the current cursor.
- `character` will provide the character at the cursor.
- `accept` will take in a string of characters that the scanner will accept
  in order to advance. It will return the character accepted or nil.
- raise `EndOfFileError` when it reaches the end of the file.

# Context Free Language

Program := { Expression } ;

Expression := Literal ;

Literal := NumericLiteral ;

NumericLiteral := Digit { Digit } ;

Digit := "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
