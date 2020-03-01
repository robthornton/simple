# frozen_string_literal: true

require_relative('./file.rb')
require_relative('./lexer.rb')
require_relative('./parser.rb')
require_relative('./c_generator.rb')

input = File.open('./test.smpl')
output = File.open('./test.c', 'w')

source = input.read

file = SimpleFile.new(name: 'test.smpl', source: source, length: source.length)
lexer = Lexer.new(file)
parser = Parser.new(lexer)

program = parser.parse

generator = CGenerator.new(out: output)
generator.generate(program)
