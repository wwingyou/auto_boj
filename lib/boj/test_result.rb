# frozen_string_literal: true

module Boj
  class TestResult
    attr_reader :testcase, :status, :output, :error, :time

    def initialize(testcase, status, output, error, time)
      @testcase = testcase
      @status = status
      @output = output
      @error = error
      @time = time
    end

    def inspect
      "<Result of (#{testcase}) => #{status}, #{time} millisec>"
    end

    def to_s
      inspect
    end
  end
end
