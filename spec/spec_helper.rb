require "rspec"
require File.dirname(__FILE__)+ '/../src/geometry/space.rb'

module RSpec
  module Matchers
    def be_very_close(expected, delta = ::Float::EPSILON)
      be_within(delta).of(expected)
    end
  end
end
