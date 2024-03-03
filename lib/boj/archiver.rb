# frozen_string_literal: true

module Boj
  module Archiver
    extend self

    def archive
      archive_root_path = File.expand_path(archive_root, Dir.pwd)
      if Dir.exist?(archive_root_path)
        puts '이미 저장된 문제가 존재합니다. 문제를 덮어씁니다.'
      else
        Dir.mkdir(archive_root_path)
      end

      stage_root_path = File.expand_path(stage_root, Dir.pwd)
      Dir.mkdir(stage_root_path) unless Dir.exist?(stage_root_path)

      if Boj.session.problem.nil?
        puts '풀고 있는 문제가 없습니다.'
        puts "'boj pull <code>'로 문제를 먼저 가져오세요."
        return
      end

      archive_dir_path = File.expand_path(pollinated_dir_name, archive_root_path)
      Dir.mkdir(archive_dir_path) unless Dir.exist?(archive_dir_path)

      files = Dir.glob(File.join(stage_root_path, '*'))

      files.each do |file|
        FileUtils.cp(file, archive_dir_path)
      end

      puts "현재 문제가 다음 경로에 저장되었습니다.\n\"#{archive_dir_path}\""
    end

    private

    def archive_root
      Boj.config['archive_path']
    end

    def stage_root
      Boj.config['stage_path']
    end

    def problem_path_format_string
      Boj.config['archive_format']
    end

    def pollinated_dir_name
      problem_path_format_string.gsub(/%([^%]+)%/) { |_s| Boj.session.problem.send(::Regexp.last_match(1).to_sym) }
    end
  end
end
