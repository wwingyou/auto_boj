# frozen_string_literal: true

# stdlib
require "fileutils"

module Boj
  # internal requires
  autoload :CLI,                "boj/cli"
  autoload :Parser,             "boj/parser"
  autoload :Fetcher,            "boj/fetcher"
  autoload :TestcaseRunner,     "boj/testcase_runner"
  autoload :Utils,              "boj/utils"
  autoload :Session,            "boj/session"
  autoload :Configuration,      "boj/configuration"
  autoload :Archiver,           "boj/archiver"
  autoload :Problem,            "boj/problem"
  autoload :Testcase,           "boj/testcase"
  autoload :TestResult,         "boj/test_result"
  autoload :TestcaseIO,         "boj/testcase_io"
  autoload :Helper,             "boj/helper"

  class << self
    def session
      @session ||= Boj::Session.new
    end

    def config
      @config ||= Boj::Configuration.load
    end
    
    def root_dir
      Dir.pwd
    end
  end
end
