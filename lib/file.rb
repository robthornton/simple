# typed: true
# frozen_string_literal: true

require('sorbet-runtime')

require('./position.rb')

module Simple
  # File represents a file containing source code.
  class File
    extend T::Sig

    sig { returns(String) }
    attr_reader :source

    sig { params(pos: Integer).returns(T::Array[Integer]) }
    def add_newline(pos)
      @new_lines << pos
    end

    sig { params(pos: Integer).returns(Position) }
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

    sig { returns(String) }
    attr_reader :name

    sig { returns(T::Array[Integer]) }
    attr_reader :new_lines

    sig { params(source: String, length: Integer, name: String).void }
    def initialize(source:, length:, name: '')
      @name = name
      @source = source
      @length = length
      @new_lines = [0]
    end
  end
end
