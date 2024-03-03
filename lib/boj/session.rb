# frozen_string_literal: true

module Boj
  class Session < Hash
    attr_reader :problem, :language, :tag

    def initialize
      @problem = Boj::Problem.load
      if File.exist?(".session")
        File.open(".session", 'r') do |file|
          @language = file.readline().chomp().strip()
          @tag = file.readline().chomp().strip()
        end
      elsif
        @language = Boj.config["default_language"]
        @tag = Boj.config["default_tag"]
      end
    end

    def save
      File.open(".session", 'w') do |file|
        file.puts language
        file.puts tag
      end
    end

    # FIXME: 필요없는 코드가 될것 같다
    def checkout(args = {})
      language = args[:language] || @language
      tag = args[:tag] || @tag

      Session.new
    end

    def ==(other)
      return false if other.class != Session
      code == other.code and language == other.language and tag == other.tag
    end

    def to_s
      unless problem.nil?
        "\t문제: #{problem}\n\t언어: #{language}\n\t태그: #{tag}"
      else
        "가져온 문제가 없습니다. \n'boj pull <code>'를 이용해 문제를 가져오세요."
      end
    end
  end
end
