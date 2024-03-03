# frozen_string_literal: true

module Boj
  class CLI::Status
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def run
      puts Boj.session
    end
  end
end
