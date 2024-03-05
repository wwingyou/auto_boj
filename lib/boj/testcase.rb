# frozen_string_literal: true

module Boj
  # 테스트케이스의 태그, 인풋, 아웃풋을 담고 있는 데이터 모델
  class Testcase
    attr_reader :tag, :input, :output

    def initialize(tag, input, output)
      @tag = tag
      @input = input
      @output = output
    end

    def inspect
      "<Testcase: #{tag}>"
    end

    def to_s
      inspect
    end
  end
end
