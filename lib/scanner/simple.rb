# typed: true
# frozen_string_literal: true

require_relative('./interface.rb')

module Scanner
  # Scanner steps through an input file, one character at a time.
  class Simple < Interface
    extend T::Sig

    sig { override.returns(String) }
    attr_reader :character

    sig { override.returns(Integer) }
    attr_reader :position

    sig { override.params(characters: String).returns(String) }
    def accept(characters)
      temporary = character
      return '' unless characters.include?(character)

      step
      temporary
    end

    sig { override.void }
    def ignore
      step
    end

    private

    sig { returns(Integer) }
    attr_reader :reading_position

    sig { returns(String) }
    attr_reader :source

    sig { params(character: String).void }
    attr_writer :character

    sig { params(position: Integer).void }
    attr_writer :position

    sig { params(reading_position: Integer).void }
    attr_writer :reading_position

    sig { params(source: String).void }
    def initialize(source = '')
      @source = source
      @character = ''
      @position = 0
      @reading_position = 0

      step unless source.empty?
    end

    sig { void }
    def step
      self.character = ''

      return if position >= source.length

      self.position = reading_position
      self.character = T.must(source[position]) unless source[position].nil?
      self.reading_position = reading_position + 1
    end
  end
end
