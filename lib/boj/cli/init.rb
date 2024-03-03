# frozen_string_literal: true

module Boj
  class CLI::Init
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def run
      if Helper.initialized?
        puts '이미 초기화된 디렉토리입니다.'
      else
        Helper.initialize_dir Dir.pwd
        puts '현재 디렉토리를 초기화했습니다.'
      end
    end
  end
end
