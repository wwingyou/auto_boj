# frozen_string_literal: true

require 'boj/testcase'
require_relative 'spec_helper'

RSpec.describe Boj::Testcase do
  source = <<~TEST
    ==테스트1
    1 2
    =>
    3
  TEST
  obj = Boj::Testcase.new('테스트1', '1 2', '3')
  same = Boj::Testcase.new('테스트1', '1 2', '3')
  diff1 = Boj::Testcase.new('테스트2', '1 2', '3')
  diff2 = Boj::Testcase.new('테스트1', '1 2 3', '3')
  diff3 = Boj::Testcase.new('테스트1', '1 2', '9')

  it_behaves_like('serializable',
                  Boj::Testcase,
                  obj,
                  source,
                  same,
                  [diff1, diff2, diff3],
                  '<Testcase: 테스트1>')
end
