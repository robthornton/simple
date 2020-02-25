# frozen_string_literal: true

# EndOfInputError indicates the scanner has reached the end of input.
class EndOfInputError < StandardError
  def initialize(message = nil)
    error_message = 'End of input has been reached'
    error_message += ": #{message}" if message
    super(error_message)
  end
end

# Scanner steps through an input file, one character at a time.
class Scanner
  attr_reader :character, :position

  def accept(characters)
    temporary = character
    return unless characters.include?(character)

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
    self.position = reading_position

    raise EndOfInputError if position > source.length

    self.character = source[position]
    self.character = '' if character.nil?
    self.reading_position = reading_position + 1
  end
end
