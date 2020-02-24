# frozen_string_literal: true

# File represents a file containing source code.
class SimpleFile
  attr_reader :source

  def add_newline(pos)
    @new_lines << pos
  end

  def position(pos = 0)
    line = 0
    column = pos

    new_lines.each_with_index do |line_position, index|
      line = index
      column = pos - line_position

      break if pos < line_position
    end

    Position.new(file_name: name, line: line, column: column)
  end

  private

  attr_reader :name, :new_lines

  def initialize(name: '', source:, length:)
    @name = name
    @source = source
    @length = length
    @new_lines = [0]
  end
end
