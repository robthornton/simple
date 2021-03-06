# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require('item.rb')
require('scanner.rb')
require('lexer_interface.rb')

module Simple
  # Lexer is a lexical analyzer. Each call to scan will return a new
  # Token.
  class Lexer < LexerInterface
    extend T::Sig

    sig { override.returns(Item) }
    def scan
      skip_whitespace

      return scan_integer if digit?
      return scan_identifier if alpha?
      return scan_operator if operator?
      return scan_comma if comma?

      if eof?
        return Item.new(literal: '', position: scanner.position, token: Token::EOF)
      end

      Item.new(literal: scanner.character, position: scanner.position, token: Token::Unknown)
    end

    private

    sig { returns(Simple::File) }
    attr_reader :file

    sig { returns(ScannerInterface) }
    attr_reader :scanner

    DIGITS = '0123456789'
    OPERATORS = '+-*/:'
    LOWER = 'abcdefghijklmnopqrstuvwxyz'
    UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    ALPHA = T.let(UPPER + LOWER, String)
    WHITESPACE = " \t\n\r"

    private_constant :ALPHA, :DIGITS, :OPERATORS, :WHITESPACE

    sig { returns(T::Boolean) }
    def alpha?
      ALPHA.include?(scanner.character) && !eof?
    end

    sig { returns(T::Boolean) }
    def comma?
      scanner.character == ',' && !eof?
    end

    sig { returns(T::Boolean) }
    def digit?
      DIGITS.include?(scanner.character) && !eof?
    end

    sig { returns(T::Boolean) }
    def operator?
      OPERATORS.include?(scanner.character) && !eof?
    end

    sig { params(ident: String).returns(Token) }
    def ident_token(ident)
      case ident
      when 'var'
        Token::Var
      else
        Token::Identifier
      end
    end

    sig { params(scanner: ScannerInterface, file: Simple::File).void }
    def initialize(scanner:, file:)
      @file = file
      @scanner = scanner
    end

    sig { params(literal: String, position: Integer).returns(Item) }
    def scan_assignment(literal:, position:)
      token = Token::Unknown
      token = Token::Assignment if literal == ':'

      literal += scanner.accept('=')

      Item.new(literal: literal, position: position, token: token)
    end

    sig { returns(Item) }
    def scan_comma
      position = scanner.position
      Item.new(literal: scanner.accept(','), position: position, token: Token::Comma)
    end

    sig { returns(Item) }
    def scan_identifier
      start = scanner.position
      literal = ''
      ch = scanner.accept(ALPHA)

      until ch.empty?
        literal += ch
        ch = scanner.accept(ALPHA)
      end

      Item.new(literal: literal, position: start, token: ident_token(literal))
    end

    sig { returns(Item) }
    def scan_integer
      start = scanner.position
      literal = ''
      ch = scanner.accept(DIGITS)

      until ch.empty?
        literal += ch
        ch = scanner.accept(DIGITS)
      end

      Item.new(literal: literal, position: start, token: Token::Integer)
    end

    sig { returns(Item) }
    def scan_operator
      position = scanner.position
      literal = scanner.accept(OPERATORS)

      token = Token::Unknown
      token = Token::AddOperator if literal == '+'
      token = Token::SubtractOperator if literal == '-'
      token = Token::MultiplyOperator if literal == '*'
      token = Token::DivisionOperator if literal == '/'

      if scanner.character == '='
        return scan_assignment(literal: literal, position: position)
      end

      Item.new(literal: literal, position: position, token: token)
    end

    sig { returns(T::Boolean) }
    def eof?
      scanner.character.empty?
    end

    sig { void }
    def skip_whitespace
      character = scanner.character
      character = scanner.accept(WHITESPACE) until character.empty?
    end
  end
end
