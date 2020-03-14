# typed: false
# frozen_string_literal: true

require_relative 'ast.rb'
require_relative 'lexer.rb'

# Simple language namespace
module Simple
  # The Parser produces an abstract syntax tree
  class Parser
    extend T::Sig

    sig { returns(Ast::Program) }
    def parse
      item = lexer.scan
      expression = parse_expression(item)

      p = Ast::Program.new
      p.add_expression(expression)
      p
    end

    private

    sig { returns(Lexer) }
    attr_reader :lexer

    sig { params(lexer: Lexer).void }
    def initialize(lexer)
      @lexer = lexer
    end

    sig { params(item: Item).returns(Expression) }
    def parse_expression(item)
      expression = NumericLiteral.new(literal: item.literal, position: item.position)

      item = lexer.scan
      return expression if item.token == Token::EOF

      parse_binary_expression(item: item, lhs: expression)
    end

    sig { params(item: Item, lhs: Expression).returns(BinaryExpression) }
    def parse_binary_expression(item:, lhs:)
      operator = item.literal
      rhs = NumericLiteral.new(literal: item.literal, position: item.position)

      BinaryExpression.new(lhs: lhs, operator: operator, rhs: rhs)
    end
  end
end
