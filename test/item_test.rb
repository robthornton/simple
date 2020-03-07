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
end
