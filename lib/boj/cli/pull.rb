# frozen_string_literal: true

module Boj
  class CLI::Pull
    attr_reader :code, :options

    def initialize(options, code)
      @options = options
      @code = code
    end

    def run
      # TODO: 변경사항이 있다면 스테이지 영역을 우선 아카이빙한 후 새 문제를 로드한다
      html = Boj::Fetcher.html_from code
      problem = Boj::Parser.problem_from html

      problem.write
      Boj.session.save

      # 필요한 파일들을 워킹 디렉토리에 저장한다.
      exts = { java: 'java', python: 'py', ruby: 'rb' }
      stage_path = Boj.config['stage_path']
      lang = Boj.config['default_language']
      tag = Boj.config['default_tag']
      # 솔루션 템플릿 복사
      FileUtils.cp("#{$template_dir}/#{lang}.#{exts[lang.to_sym]}", "#{stage_path}/#{tag}.#{exts[lang.to_sym]}")
      # 리드미 템플릿 복사
      FileUtils.cp("#{$template_dir}/README.md", "#{stage_path}/README.md")

      puts '문제를 성공적으로 받아왔습니다.'
      puts "[#{problem.code}번] #{problem.title}"
    end
  end
end
