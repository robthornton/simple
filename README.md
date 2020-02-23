# Overview

A simple interpreter for a simple language.

# Lexer

A lexer reads input from a source string one character at a time, producing
tokenized output of characters. There is one literal that can currently be
scanned for:

- Integer: A `NumericLiteral` consisting of the characters "0" through "9".

The scanner will skip `Whitespace` characters. Any other character is an
error of type `UnknownCharacterError`. At the end of a file, the lexer will
return a scan item indicating the end of the file.

For each literal found, the lexer will produce an `Item` which contains:

- Token: A numerical constant representing the type of literal found.
- Literal: The string matching the type.
- Position: The starting position at which the literal was found.

In order to get detailed information about where the literal is located
within the input source, there is a `File` which can be passed a position
that will return the following details:

- File Name: The name of the source, if any. May be the empty string.
- Line: The line on which the literal appeared.
- Column: The column offset at which the literal appears.

Newlines, though skipped as `Whitespace` are used to calculate positional
information.

## Scanner

At its core is a scanner whose job is to advance through the source code one
character at a time. It will:

- take in a string of characters that consists of the entire file to be
  scanned.
- report the `position` of the current cursor.
- `character` will provide the character at the cursor.
- `accept` will take in a string of characters that the scanner will accept
  in order to advance. It will return the character accepted or nil.
- raise `EndOfInputError` when it reaches the end of the file.

# Context Free Language

Program := { Expression } ;

Expression := Literal ;

Literal := NumericLiteral ;

NumericLiteral := Digit { Digit } ;

Digit := "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

Whitespace := " " | "\t" | "\n" | "\r"
