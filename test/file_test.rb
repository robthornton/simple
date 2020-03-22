# typed: true
# frozen_string_literal: true

require('minitest/autorun')
require('file.rb')

class TestFile < Minitest::Test
  def test_file_source
    f = Simple::File.new(name: 'file.smpl', source: '123', length: 3)

    assert_equal('123', f.source)
  end

  def test_file_position_zero
    f = Simple::File.new(name: 'file.smpl', source: '', length: 1)
    position = f.position

    assert_equal('file.smpl', position.file_name)
    assert_equal(0, position.line)
  end

  def test_file_position_at_position
    f = Simple::File.new(name: '', source: '', length: 2)
    position = f.position(1)

    assert_equal(1, position.column)
    assert_equal(0, position.line)
  end

  def test_file_position_with_newline
    f = Simple::File.new(name: '', source: '', length: 2)
    f.add_newline(1)

    position = f.position(2)

    assert_equal(1, position.column)
    assert_equal(1, position.line)
  end
end
