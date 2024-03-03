# frozen_string_literal: true

module Boj
  class CLI::Checkout
    attr_reader :code, :options

    def initialize(options, code)
      @options = options
      @code = code
    end

    def run
      new_session = Boj.session.checkout(code: code)
      new_session.save
      puts "다른 문제로 전환되었습니다.\n#{new_session}"
    end
  end
end
