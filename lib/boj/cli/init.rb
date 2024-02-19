# frozen_string_literal: true

module Boj
  class CLI::Init
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def run
      archive_exist = Dir.exist?(Boj.config["archive_path"])
      stage_exist = Dir.exist?(Boj.config["stage_path"])
      if archive_exist and stage_exist
        puts "이미 초기화된 디렉토리입니다." 
      else
        Dir.mkdir(Boj.config["archive_path"]) unless archive_exist
        Dir.mkdir(Boj.config["stage_path"]) unless stage_exis1 
        puts "현재 디렉토리를 초기화하했습니다."
      end
    end
  end
end
