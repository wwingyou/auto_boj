# frozen_string_literal: true

module Boj
  class Testcase 
    attr_reader :tag, :input, :output

    def initialize(tag, input, output)
      @tag = tag
      @input = input
      @output = output
    end

    def inspect
      "<Testcase #{tag}>"
    end

    def to_s
      self.inspect
    end
  end
end
