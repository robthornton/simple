# frozen_string_literal: true

# Position contains the file name, line and column of a literal
class Position
  attr_reader :column, :file_name, :line

  private

  def initialize(file_name:, line:, column:)
    @column = column
    @file_name = file_name
    @line = line
  end
end
