# typed: strong
# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'

Dir['./test/**/*_test.rb'].sort.each do |file|
  require file
end
