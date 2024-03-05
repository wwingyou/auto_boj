# frozen_string_literal: true

module Boj
  # 테스트케이스의 태그, 인풋, 아웃풋을 담고 있는 데이터 모델
  # 직렬화 및 역직렬화를 할 수 있다.
  class Testcase
    attr_reader :tag, :input, :output

    TAG_PREFIX = '=='
    OUTPUT_PREFIX = '=>'

    class << self
      def deserialize(source)
        tag = ''
        input = ''.dup
        output = ''.dup
        getting_input = true
        source.lines.map(&:chomp).each do |line|
          if line =~ /^#{TAG_PREFIX}(.+)/
            tag = Regexp.last_match(1)
            next
          end
          if line =~ /^#{OUTPUT_PREFIX}/
            getting_input = false
            next
          end
          if getting_input
            input.concat(line, "\n")
          else
            output.concat(line, "\n")
          end
        end
        Testcase.new(tag, input.chomp, output.chomp)
      end
    end

    def initialize(tag, input, output)
      @tag = tag
      @input = input
      @output = output
    end

    def serialize
      "#{TAG_PREFIX}#{tag}\n#{input}\n#{OUTPUT_PREFIX}\n#{output}"
    end

    def ==(other)
      tag == other.tag && input == other.input && output == other.output
    end

    def inspect
      "<Testcase: #{tag}>"
    end

    def to_s
      inspect
    end
  end
end
