# frozen_string_literal: true

module Boj
  class Problem
    attr_reader :code, :title, :description, :testcases

    class << self
      def load(path = nil)
        path ||= Boj.config['stage_path']
        return unless File.exist?("#{path}/.meta")

        code = nil, title = nil, description = nil
        # 메타데이터 가져오기
        File.open("#{path}/.meta", 'r') do |file|
          code = file.readline.chomp.strip
          title = file.readline.chomp.strip
          description = file.readline.chomp.strip
        end
        testcases = Boj::TestcaseIO.new(path).read

        Boj::Problem.new(code, title, description, testcases)
      end
    end

    def initialize(code, title, description, testcases)
      @code = code
      @title = title
      @description = description
      @testcases = testcases
    end

    def write(path = nil)
      path ||= Boj.config['stage_path']
      File.open("#{path}/.meta", 'w') do |file|
        file.puts code
        file.puts title
        file.puts description
      end
      Boj::TestcaseIO.new(path).write testcases
    end

    def inspect
      "<Problem #{code}:#{title}>"
    end

    def to_s
      inspect
    end
  end
end
