# typed: true
# frozen_string_literal: true

require('ast/main.rb')
require('lexer.rb')
require('parser_interface.rb')

# Simple language namespace
module Simple
  # The Parser produces an abstract syntax tree
  class Parser < ParserInterface
    extend T::Sig

    sig { override.returns(AST::Program) }
    def parse
      next_item
      expression = parse_expression

      program = AST::Program.new
      program.add_expression(expression)
      program
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

    sig { returns(AST::Expression) }
    def parse_expression
      return parse_var if item.token == Token::Var

      expression = AST::NumericLiteral.new(literal: item.literal, position: item.position)

      next_item
      return expression if item.token == Token::EOF

      parse_binary_expression(item: item, lhs: expression)
    end

    sig { params(item: Item, lhs: AST::Expression).returns(AST::Binary) }
    def parse_binary_expression(item:, lhs:)
      operator = item.literal

      next_item
      rhs = parse_expression

      AST::Binary.new(lhs: lhs, operator: operator, rhs: rhs)
    end

    sig { returns(T::Array[AST::Identifier]) }
    def parse_identifier_list
      identifiers = T.let([], T::Array[AST::Identifier])
      # more = T.let(true, T::Boolean)

      # while more
      identifiers << AST::Identifier.new(literal: item.literal, position: item.position)

      # more = false if item.token == Token::Comma
      # end

      identifiers
    end

    sig { returns(AST::Var) }
    def parse_var
      var = expect(Token::Var)
      next_item

      identifiers = parse_identifier_list

      AST::Var.new(var: var, identifiers: identifiers)
    end
  end
end
