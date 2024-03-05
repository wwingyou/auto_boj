# frozen_string_literal: true

module Boj
  # 현재 풀이중인 문제에 대한 정보를 담는 클래스이다.
  # 반드시 싱글톤으로 사용될 필요는 없으나, 루트 모듈등에서 하나의
  # 오브젝트만 유지하는 용도로 설계되었다.
  class Session
    attr_reader :pcode, :language, :tag, :status

    def initialize(pcode, language, tag, status)
      @pcode = pcode
      @language = language
      @tag = tag
      @status = status
    end

    def serialize
      [pcode, language, tag, status.to_s].join("\n")
    end

    def self.deserialize(source)
      props = source.lines.map(&:chomp)
      Session.new(props[0], props[1], props[2], props[3].to_sym)
    end

    def ==(other)
      return false if other.class != Session

      pcode == other.pcode &&
        language == other.language &&
        tag == other.tag &&
        status == other.status
    end

    def to_s
      "<Session: #{pcode}, #{language}, #{tag}, #{status}>"
    end
  end
end
