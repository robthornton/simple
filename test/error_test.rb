# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/scanner.rb'

class TestErrors < Minitest::Test
  def test_end_of_input_error
    assert(EndOfInputError.new)
  end
end
