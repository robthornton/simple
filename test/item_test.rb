# typed: true
# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/item.rb'

class TestLexer < Minitest::Test
  def test_item_eof
    item = Item.new(literal: '', position: 0, token: Token::EOF)

    assert_equal('', item.literal)
    assert_equal(0, item.position)
    assert_equal(Token::EOF, item.token)
  end

  def test_item_integer_literal
    item = Item.new(literal: '123', position: 0, token: Token::Integer)

    assert_equal('123', item.literal)
    assert_equal(0, item.position)
    assert_equal(Token::Integer, item.token)
  end

  def test_item_unknown_literal
    item = Item.new(literal: '', position: 0, token: Token::Unknown)

    assert_equal(Token::Unknown, item.token)
  end

  def test_item_add_operator
    item = Item.new(literal: '+', position: 0, token: Token::AddOperator)

    assert_equal(Token::AddOperator, item.token)
  end

  def test_item_subtract_operator
    item = Item.new(literal: '-', position: 0, token: Token::SubtractOperator)

    assert_equal(Token::SubtractOperator, item.token)
  end

  def test_item_multiply_operator
    item = Item.new(literal: '*', position: 0, token: Token::MultiplyOperator)

    assert_equal(Token::MultiplyOperator, item.token)
  end

  def test_item_division_operator
    item = Item.new(literal: '/', position: 0, token: Token::DivisionOperator)

    assert_equal(Token::DivisionOperator, item.token)
  end

  def test_item_var_keyword
    item = Item.new(literal: 'var', position: 0, token: Token::Var)

    assert_equal(Token::Var, item.token)
  end

  def test_item_identifier
    item = Item.new(literal: 'ident', position: 0, token: Token::Identifier)

    assert_equal(Token::Identifier, item.token)
  end

  def test_item_comma_separator
    item = Item.new(literal: ',', position: 0, token: Token::Comma)

    assert_equal(Token::Comma, item.token)
  end

  def test_item_assignment_operator
    item = Item.new(literal: ':=', position: 0, token: Token::Assignment)

    assert_equal(Token::Assignment, item.token)
  end
end
