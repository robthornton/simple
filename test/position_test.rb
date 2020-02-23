# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../src/position.rb'

class TestPosition < Minitest::Test
  def test_position_new
    p = Position.new(file_name: 'file.smpl', line: 2, column: 5)

    assert_equal('file.smpl', p.file_name)
    assert_equal(2, p.line)
    assert_equal(5, p.column)
  end
end
