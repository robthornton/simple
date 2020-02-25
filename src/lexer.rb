# frozen_string_literal: true

require_relative 'item.rb'

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

      Item.new(literal: literal, position: start, token: Token::INTEGER)
    end
  end
end

# Lexer is a lexical analyzer. Each call to scan will return a new
# Token.
class Lexer
  def scan
    return scan_integer if digit?

    Item.new(literal: '', position: 0, token: Token::EOF)
  end

  private

  attr_reader :file, :scanner

  DIGITS = '0123456789'
  private_constant :DIGITS

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

    Item.new(literal: literal, position: start, token: Token::INTEGER)
  end

  def eof?
    scanner.character.empty?
  end
end
