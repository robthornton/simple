# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'item.rb'
require_relative 'scanner.rb'

# Lexer is a lexical analyzer. Each call to scan will return a new
# Token.
class Lexer
  extend T::Sig

  sig { returns(Item) }
  def scan
    skip_whitespace

    return scan_integer if digit?

    if eof?
      return Item.new(literal: '', position: scanner.position, token: Token::EOF)
    end

    Item.new(literal: scanner.character, position: scanner.position, token: Token::Unknown)
  end

  private

  sig { returns(SimpleFile) }
  attr_reader :file

  sig { returns(Scanner) }
  attr_reader :scanner

  DIGITS = '0123456789'
  WHITESPACE = " \t\n\r"
  private_constant :DIGITS, :WHITESPACE

  sig { returns(T::Boolean) }
  def digit?
    DIGITS.include?(scanner.character) && !eof?
  end

  sig { params(file: SimpleFile).void }
  def initialize(file)
    @file = file
    @scanner = Scanner.new(file.source)
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
