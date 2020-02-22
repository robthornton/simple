# frozen_string_literal: true

# Scanner steps through an input file, one character at a time.
class Scanner
  attr_reader :character, :position

  def initialize
    @character = ''
    @position = 0
  end
end
