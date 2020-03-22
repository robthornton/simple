# typed: true
# frozen_string_literal: true

require('./bootstrap.rb')

require('c_generator.rb')
require('file.rb')
require('lexer/main.rb')
require('parser/main.rb')

input = File.open('./test.smpl')
output = File.open('./test.c', 'w')

source = T.must(input.read)

file = SimpleFile.new(name: 'test.smpl', source: source, length: source.length)
lexer = Lexer.new(file)
parser = Simple::Parser.new(lexer)

program = parser.parse

generator = CGenerator::Program.new(out: output)
generator.generate(program)
