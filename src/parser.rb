# typed: true
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

    sig { params(item: Item).returns(Ast::Expression) }
    def parse_expression(item)
      return parse_var(item) if item.token == Token::Var

      expression = Ast::NumericLiteral.new(literal: item.literal, position: item.position)

      item = lexer.scan
      return expression if item.token == Token::EOF

      parse_binary_expression(item: item, lhs: expression)
    end

    sig { params(item: Item, lhs: Ast::Expression).returns(Ast::BinaryExpression) }
    def parse_binary_expression(item:, lhs:)
      operator = item.literal

      item = lexer.scan
      rhs = parse_expression(item)

      Ast::BinaryExpression.new(lhs: lhs, operator: operator, rhs: rhs)
    end

    sig { params(item: Item).returns(Ast::VarExpression) }
    def parse_var(item)
      var = item.position
      item = lexer.scan

      ident = Ast::Identifier.new(literal: item.literal, position: item.position)

      Ast::VarExpression.new(var: var, identifiers: [ident])
    end
  end
end
