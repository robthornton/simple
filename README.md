# Overview

A simple interpreter for a simple language.

# Lexer

A lexer reads input from a source string one character at a time, producing
tokenized output of characters. There is one literal that can currently be
scanned for:

- Integer: A `NumericLiteral` consisting of the characters "0" through "9".

The scanner will skip `Whitespace` characters. Any other character is
emitted as type `Unknown`. At the end of a file, the lexer will return a
scan item indicating the end of the file.

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

Expression := BinaryExpression | VarExpression | Literal ;

BinaryExpression := Expression ArithmeticOperator Expression ;

VarExpression := "var" Identifier [ "," Identifier [ Type ] ] Type [ VarAssignment ] ;

VarAssignment := AssignmentOperator Expression [ "," Expression ] ;

Type := Identifier ;

Identifier := /[A-Za-z]/ { /[A-Za-z0-9_]/ }

Literal := NumericLiteral ;

NumericLiteral := Digit { Digit } ;

ArithmeticOperator := "+" | "-" | "/" | "\*" ;

AssignmentOperator := ":=" ;

Digit := "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

Whitespace := " " | "\t" | "\n" | "\r"

## Parser

The parser performs syntax analysis. It makes sure the scanned items conform
to the context free language. It:

- Takes input by way of a SimpleFile.
- Accepts a Lexer to use.
- Generates an abstract syntax tree when #parse is called.
- It only does syntax analysis.

## Abstract Syntax Tree

Represents the parsed items. The context free language describes the tree.

## Code Generator

- Compiles a Program to C

## Optimization

The C language is one of the most mature languages still in common use
today. A tremendous amount of effort has been made to add optimizations
to the code generator in GCC and other compilers for the language. As
such, the minimal advantages that could be provided within Simple's
compiler would probably end up producing code that the an optimizing C
compiler can't optimize as well.

As such, this compiler will make no attempts at optimizing in any way.

# Language Notes

The purpose of this sections is more for internal notes and thought
experiments. It is not meant to be a language resource.

## Types

### Built-in

- "int" | "int8" | "int16" | "int32" | "int64"
- "uint" | "uint8" | "uint16" | "uint32" | "uint64"

- `int` is an alias for the architecture's standard word size.
- `int8` -> `char` in C
- `int16` -> `short` in C
- `int32` -> `long` in C
- `int64` -> `long long` in C
- `uint` is an alias for the architecture's standard word size, unsigned.
- `uint8` -> `unsigned char` in C
- `uint16` -> `unsigned short` in C
- `uint32` -> `unsigned long` in C
- `uint64` -> `unsigned long long` in C

## Operators

### Math

a + b
a - b
a \* b
a / b

- Parentheses used for precidence "(a + b) \* c".

### Bitwise Operators

a & b
a | b

### Logical Operators

a < b // Less than
a = b
a > b
a <= b
a >= b
a != b

### Assignment Operators

":=" is standard assignment. The other assigment operators match their mathematical
equivilents. There are no increment or decrement operators at this time.

a := b
a += b
a -= b
a \*= b
a /= b

## Expressions

### Variable Declarations

Declare a public/exported variable named `MyVariable`.

```
var MyVariable int
```

Variables are always initialized to the zero value of their type. If
the optional assignment operator is included, then the number of
expressions must match the number of identifiers.

The side effects of an assignment is the value of the declared variable.

```
var Variable1 int := var Variable0 int := 32
```

`Variable0 == 42` and `Variable1 == 42`. Of course, it would clearer, shorter
and recommended to write:

```
var Variable0, Variable1 := 42, 42
```

A third possibility would be to write:

```
var Variable0, Variable1 := 42, Variable0
```

...since variables are declared, and their matching assignments evaluated,
left to right, this is perfectly viable. However, since it comes at the cost
of readability, it is not recommended.

# Potential Future Additions

## Operators

- shifting (arithmetic and bitwisee) operators ("<<", "<=", ">>", ">=")
- logical operators ("&&", "||")
- arithmetic operators ("^" => exponential, "^=")
- bitwise operators ("&", "|")

## Keywords

- switch-case
