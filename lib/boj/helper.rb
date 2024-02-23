## frozen_string_literal: true

module Boj
  module Helper
    extend self

    # 루트 디렉토리가 초기화되어있는지 확인한다.
    def initialized?
      archive_exist = Dir.exist?(File.expand_path(Boj.config["archive_path"], Boj.root_dir))
      stage_exist = Dir.exist?(File.expand_path(Boj.config["stage_path"], Boj.root_dir))
      archive_exist and stage_exist
    end

    # 'path' 디렉토리를 초기화한다.
    def initialize_dir(path)
      archive_path = File.expand_path(Boj.config["archive_path"], Boj.root_dir)
      stage_path = File.expand_path(Boj.config["stage_path"], Boj.root_dir)
      Dir.mkdir(Boj.config["archive_path"]) unless Dir.exist? archive_path
      Dir.mkdir(Boj.config["stage_path"]) unless Dir.exist? stage_path
    end
  end
  
end
