# typed: false
# frozen_string_literal: true

require_relative 'item.rb'
require_relative 'scanner.rb'

# Lex contains variables lexer modules that can be included into the Lexer
# class
module Lex
  # Integer is used to scan for integer literals
  module Integer
    private

    def scan_integer(scanner)
      start = scanner.position
      literal = scanner.character

      loop do
        character = scanner.accept(self.DIGITS)
        literal += charater
        break unless character.nil?
      end

      Item.new(literal: literal, position: start, token: Token::Integer)
    end
  end
end

# Lexer is a lexical analyzer. Each call to scan will return a new
# Token.
class Lexer
  def scan
    skip_whitespace

    return scan_integer if digit?

    if eof?
      return Item.new(literal: '', position: scanner.position, token: Token::EOF)
    end

    Item.new(literal: scanner.character, position: scanner.position, token: Token::Unknown)
  end

  private

  attr_reader :file, :scanner

  DIGITS = '0123456789'
  WHITESPACE = " \t\n\r"
  private_constant :DIGITS, :WHITESPACE

  def digit?
    DIGITS.include?(scanner.character) && !eof?
  end

  def initialize(file)
    @file = file
    @scanner = Scanner.new(file.source)
  end

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

  def eof?
    scanner.character.empty?
  end

  def skip_whitespace
    character = scanner.character
    character = scanner.accept(WHITESPACE) until character.empty?
  end
end
