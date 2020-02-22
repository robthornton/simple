# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'

Dir['./test/**/*.rb'].sort.each do |file|
  require file
end
