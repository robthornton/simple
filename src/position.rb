# typed: true
# frozen_string_literal: true

# Position contains the file name, line and column of a literal
class Position
  extend T::Sig

  sig { returns(Integer) }
  attr_reader :column

  sig { returns(String) }
  attr_reader :file_name

  sig { returns(Integer) }
  attr_reader :line

  private

  sig { params(file_name: String, line: Integer, column: Integer).void }
  def initialize(file_name:, line:, column:)
    @column = column
    @file_name = file_name
    @line = line
  end
end
