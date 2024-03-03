# frozen_string_literal: true

module Boj
  class CLI < Thor
    desc 'init', '현재 디렉토리를 초기화합니다.'
    def init
      require 'boj/cli/init'
      Init.new(options.dup).run
    end

    desc 'pull', '백준 문제 테스트케이스를 가져옵니다.'
    def pull(code)
      require 'boj/cli/pull'
      Pull.new(options.dup, code).run
    end

    desc 'submit', '코드를 제출합니다.'
    def submit
      # TODO: 코드 제출 구현
    end

    desc 'checkout', '다른 문제로 전환합니다.'
    def checkout(code)
      require 'boj/cli/checkout'
      Checkout.new(options.dup, code).run
    end

    desc 'test', '테스트케이스를 실행합니다.'
    def test
      require 'boj/cli/test'
      Test.new(options.dup).run
    end

    desc 'status', '현재 상태를 출력합니다.'
    def status
      require 'boj/cli/status'
      Status.new(options.dup).run
    end

    desc 'archive', '현재 풀이중인 코드를 아카이브합니다.'
    def archive
      require 'boj/cli/archive'
      Archive.new(options.dup).run
    end

    desc 'debug', '디버깅용 커맨드.'
    def debug
      html = Boj::Fetcher.html_from 13_460
      problem = Boj::Parser.problem_from html
      puts problem
    end

    # FIXME: 오류 뜨길래 일단 조치해 놨는데 정확히 어떤 역할인지 모르겠다.
    def self.exit_on_failure?
      true
    end
  end
end
