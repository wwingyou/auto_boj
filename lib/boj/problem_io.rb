# frozen_string_literal: true

require_relative './domain'
require_relative './testcase_io'

module Boj
  module ProblemIO
    FILE_NAME = '.meta'

    def self.write(problem)
      File.open(FILE_NAME, 'w') do |file|
        file.puts problem.code
        file.puts problem.title
        file.puts problem.description
      end
    end

    def self.read
      code = nil, title = nil, description = nil

      File.open(FILE_NAME, 'r') do |file|
        code = file.read_line.chomp
        title = file.read_line.chomp
        description = file.read_line.chomp
      end

      testcases = TestcaseIO.read

      Problem.new(code, title, description, testcases)
    end
  end
end
