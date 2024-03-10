# frozen_string_literal: true

require 'boj/problem'
require_relative 'spec_helper'

RSpec.describe Boj::Problem do
  source = <<~TEXT
    1000
    A+B
    Bronze 5
    2 초
    128 MB
    39.319%
    1036463
    410178
    283147
  TEXT
  etc = {
    tier: 'Bronze 5',
    time_limit: '2 초',
    memory_limit: '128 MB',
    success_ratio: '39.319%',
    submission: '1036463',
    success: '410178',
    solver: '283147'
  }.freeze
  obj = Boj::Problem.new('1000', 'A+B', etc).freeze
  same = Boj::Problem.new('1000', 'A+B', etc).freeze
  diff1 = Boj::Problem.new('1001', 'A+B', etc).freeze
  diff2 = Boj::Problem.new('1000', 'A-B', etc).freeze
  diff3 = Boj::Problem.new('1000', 'A+B', {}).freeze

  it_behaves_like('serializable',
                  Boj::Problem,
                  obj,
                  source,
                  same,
                  [diff1, diff2, diff3],
                  '<Problem: 1000, A+B>')
end
