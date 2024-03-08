# frozen_string_literal: true

module Boj
  # 문제의 정보를 담는 데이터모델.
  # .meta파일에 직렬화한 정보를 저장한다.
  class Problem
    attr_reader :code, :title, :etc

    def initialize(code, title, etc = {})
      @code = code
      @title = title
      @etc = etc
    end

    class << self
      def deserialize(source)
        props = source.lines.map(&:chomp)
        etc = {
          tier: props[2],
          time_limit: props[3],
          memory_limit: props[4],
          success_ratio: props[5],
          submission: props[6],
          success: props[7],
          solver: props[8]
        }
        Problem.new(props[0], props[1], etc)
      end
    end

    def serialize
      [
        code, title,
        etc[:tier], etc[:time_limit], etc[:memory_limit],
        etc[:success_ratio], etc[:submission], etc[:success], etc[:solver]
      ].join("\n")
    end

    def ==(other)
      code == other.code && title == other.title && etc == other.etc
    end

    def inspect
      "<Problem: #{code}, #{title}>"
    end

    def to_s
      inspect
    end
  end
end
