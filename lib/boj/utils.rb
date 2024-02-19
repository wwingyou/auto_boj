# frozen_string_literal: true

module Boj
  module Utils
    extend self

    # 스트링에 포함된 줄바꿈 기호를 시스템의 줄바꿈 기호로 바꾼다.
    # 예) "hello\r\n" -> "hello\n"
    #
    # str - 정규화할 스트링
    #
    # 정규화된 스트링을 반환함
    def normalize_newline(str)
      str.gsub(/\r\n|\n/, $/)
    end
  end
end
