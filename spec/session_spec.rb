# frozen_string_literal: true

require 'boj/session'
require_relative 'spec_helper'

RSpec.describe Boj::Session do
  source = <<~TEXT
    1000
    java
    solution
    not_started
  TEXT
  obj = Boj::Session.new('1000', 'java', 'solution', :not_started).freeze
  same = Boj::Session.new('1000', 'java', 'solution', :not_started).freeze
  diff1 = Boj::Session.new('2000', 'java', 'solution', :not_started).freeze
  diff2 = Boj::Session.new('1000', 'python', 'solution', :not_started).freeze
  diff3 = Boj::Session.new('1000', 'java', 'dijkstra', :not_started).freeze
  diff4 = Boj::Session.new('1000', 'java', 'solution', :success).freeze

  it_behaves_like('serializable',
                  Boj::Session,
                  obj,
                  source,
                  same,
                  [diff1, diff2, diff3, diff4],
                  '<Session: 1000, java, solution, not_started>')
end
