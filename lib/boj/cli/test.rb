# frozen_string_literal: true

module Boj
  class CLI::Test
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def run
      testcases = Boj::TestcaseIO.new.read 
      threads = Boj::TestcaseRunner.batch testcases

      threads.each do |thread|
        result = thread.value
        case result.status
        when :success
          puts "#{result.testcase.tag}: 성공 (#{result.time} 밀리초)"
        when :fail
          puts "#{result.testcase.tag}: 실패\n아웃풋\n #{result.output}"
        when :error
          puts "#{result.testcase.tag}: 런타임 에러\n#{result.error}"
        end
      end
    end
  end
  
end
