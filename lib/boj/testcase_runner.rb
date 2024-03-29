# frozen_string_literal: true

require 'open3'

module Boj
  module TestcaseRunner
    extend self

    def batch(testcases)
      threads = []
      for testcase in testcases
        # 쓰레드가 테스트케이스를 중복으로 갖는 것을 막기 위한 람다 블록.
        # 테스트케이스를 인자로 넘겨줘서 해결함.
        block = lambda { |testcase|
          status = nil
          output = nil
          error = nil
          time = nil
          Open3.popen3("java #{Boj.config['stage_path']}/solution.java") do |i, o, e, t|
            # 프로세스가 실행될 때까지 기다리기
            pid = t.pid
            start = Time.now
            i.puts testcase.input
            i.close
            # 프로세스가 종료될 때까지 기다리기
            result = t.value

            time = Time.now - start
            output = o.read
            error = e.read
            status = if result.success?
                       (verify_output(testcase, output) ? :success : :fail)
                     else
                       :error
                     end
          end
          TestResult.new(testcase, status, output, error, time)
        }

        threads << Thread.new(testcase, &block)
      end
      threads
    end

    private

    def verify_output(testcase, output)
      answer_lines = testcase.output.lines
      output_lines = output.lines
      return false if answer_lines.size != output_lines.size

      (0...answer_lines.size).each do |i|
        return false if answer_lines[i].chomp.rstrip != output_lines[i].chomp.rstrip
      end

      true
    end
  end
end
