# typed: ignore
# frozen_string_literal: true

require_relative 'ast.rb'

# The Parser produces an abstract syntax tree
class Parser
  def initialize(lexer)
    @lexer = lexer
  end

  def parse
    item = lexer.scan
    expression = parse_expression(item)

    p = Program.new
    p.add_expression(expression)
    p
  end

  private

  attr_reader :lexer

  def parse_expression(item)
    NumericLiteral.new(literal: item.literal, position: item.position)
  end
end
