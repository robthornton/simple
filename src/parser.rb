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
      next_item
      expression = parse_expression

      p = Ast::Program.new
      p.add_expression(expression)
      p
    end

    private

    sig { returns(Lexer) }
    attr_reader :lexer

    sig { returns(Item) }
    attr_reader :item

    # sig { params(item: Item).void }
    # attr_writer :item

    sig { params(lexer: Lexer).void }
    def initialize(lexer)
      @lexer = lexer
    end

    sig { void }
    def next_item
      @item = lexer.scan
    end

    sig { params(type: Token).returns(Integer) }
    def expect(type)
      if item.token != type
        # this should actually add a parse error
        return -1
      end

      item.position
    end

    sig { returns(Ast::Expression) }
    def parse_expression
      return parse_var if item.token == Token::Var

      expression = Ast::NumericLiteral.new(literal: item.literal, position: item.position)

      next_item
      return expression if item.token == Token::EOF

      parse_binary_expression(item: item, lhs: expression)
    end

    sig { params(item: Item, lhs: Ast::Expression).returns(Ast::BinaryExpression) }
    def parse_binary_expression(item:, lhs:)
      operator = item.literal

      next_item
      rhs = parse_expression

      Ast::BinaryExpression.new(lhs: lhs, operator: operator, rhs: rhs)
    end

    sig { returns(T::Array[Ast::Identifier]) }
    def parse_identifier_list
      identifiers = T.let([], T::Array[Ast::Identifier])
      # more = T.let(true, T::Boolean)

      # while more
      identifiers << Ast::Identifier.new(literal: item.literal, position: item.position)

      # more = false if item.token == Token::Comma
      # end

      identifiers
    end

    sig { returns(Ast::VarExpression) }
    def parse_var
      var = expect(Token::Var)
      next_item

      identifiers = parse_identifier_list

      Ast::VarExpression.new(var: var, identifiers: identifiers)
    end
  end
end
