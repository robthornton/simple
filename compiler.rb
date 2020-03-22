# typed: true
# frozen_string_literal: true

require('./bootstrap.rb')

require('c_generator.rb')
require('file.rb')
require('lexer.rb')
require('parser.rb')

input = ::File.open('./test.smpl')
output = ::File.open('./test.c', 'w')

source = T.must(input.read)

file = Simple::File.new(name: 'test.smpl', source: source, length: source.length)
scanner = Simple::Scanner.new(file.source)
lexer = Simple::Lexer.new(scanner: scanner, file: file)
parser = Simple::Parser.new(lexer)

program = parser.parse

generator = Simple::CGenerator::Program.new(out: output)
generator.generate(program)
