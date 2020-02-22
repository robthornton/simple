# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/scanner.rb'

class TestScanner < Minitest::Test
  def test_new
    Scanner.new
    pass
  end

  def test_position
    assert_respond_to(Scanner.new, 'position')
  end
end
