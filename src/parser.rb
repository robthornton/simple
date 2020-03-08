# typed: ignore
# frozen_string_literal: true

require_relative 'ast.rb'

# The Parser produces an abstract syntax tree
class Parser
  extend T::Sig

  sig { params(lexer: Lexer).void }
  def initialize(lexer)
    @lexer = lexer
  end

  sig { returns(Program) }
  def parse
    item = lexer.scan
    expression = parse_expression(item)

    p = Program.new
    p.add_expression(expression)
    p
  end

  private

  sig { returns(Lexer) }
  attr_reader :lexer

  sig { params(item: Item).returns(Literal) }
  def parse_expression(item)
    NumericLiteral.new(literal: item.literal, position: item.position)
  end
end
