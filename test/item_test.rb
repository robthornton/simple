# typed: true
# frozen_string_literal: true

require('minitest/autorun')

require('item.rb')

class TestLexer < Minitest::Test
  def test_item_eof
    item = Simple::Item.new(literal: '', position: 0, token: Simple::Token::EOF)

    assert_equal('', item.literal)
    assert_equal(0, item.position)
    assert_equal(Simple::Token::EOF, item.token)
  end

  def test_item_integer_literal
    item = Simple::Item.new(literal: '123', position: 0, token: Simple::Token::Integer)

    assert_equal('123', item.literal)
    assert_equal(0, item.position)
    assert_equal(Simple::Token::Integer, item.token)
  end

  def test_item_unknown_literal
    item = Simple::Item.new(literal: '', position: 0, token: Simple::Token::Unknown)

    assert_equal(Simple::Token::Unknown, item.token)
  end

  def test_item_add_operator
    item = Simple::Item.new(literal: '+', position: 0, token: Simple::Token::AddOperator)

    assert_equal(Simple::Token::AddOperator, item.token)
  end

  def test_item_subtract_operator
    item = Simple::Item.new(literal: '-', position: 0, token: Simple::Token::SubtractOperator)

    assert_equal(Simple::Token::SubtractOperator, item.token)
  end

  def test_item_multiply_operator
    item = Simple::Item.new(literal: '*', position: 0, token: Simple::Token::MultiplyOperator)

    assert_equal(Simple::Token::MultiplyOperator, item.token)
  end

  def test_item_division_operator
    item = Simple::Item.new(literal: '/', position: 0, token: Simple::Token::DivisionOperator)

    assert_equal(Simple::Token::DivisionOperator, item.token)
  end

  def test_item_var_keyword
    item = Simple::Item.new(literal: 'var', position: 0, token: Simple::Token::Var)

    assert_equal(Simple::Token::Var, item.token)
  end

  def test_item_identifier
    item = Simple::Item.new(literal: 'ident', position: 0, token: Simple::Token::Identifier)

    assert_equal(Simple::Token::Identifier, item.token)
  end

  def test_item_comma_separator
    item = Simple::Item.new(literal: ',', position: 0, token: Simple::Token::Comma)

    assert_equal(Simple::Token::Comma, item.token)
  end

  def test_item_assignment_operator
    item = Simple::Item.new(literal: ':=', position: 0, token: Simple::Token::Assignment)

    assert_equal(Simple::Token::Assignment, item.token)
  end
end
