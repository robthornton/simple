# typed: true
# frozen_string_literal: true

# Scanner steps through an input file, one character at a time.
class Scanner
  attr_reader :character, :position

  def accept(characters)
    temporary = character
    return '' unless characters.include?(character)

    step
    temporary
  end

  def ignore
    step
  end

  private

  attr_accessor :reading_position
  attr_reader :source
  attr_writer :character, :position

  def initialize(source = '')
    @source = source
    @character = ''
    @position = 0
    @reading_position = 0

    step unless source.empty?
  end

  def step
    self.character = ''

    return if position >= source.length

    self.position = reading_position
    self.character = source[position]
    self.character = '' if character.nil?
    self.reading_position = reading_position + 1
  end
end
