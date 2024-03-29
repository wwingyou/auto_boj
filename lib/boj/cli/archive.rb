# frozen_string_literal: true

module Boj
  class CLI::Archive
    attr_reader :options

    def initialize(_options)
      @options = :options
    end

    def run
      Boj::Archiver.archive
    end
  end
end
