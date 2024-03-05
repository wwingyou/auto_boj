# frozen_string_literal: true

require 'boj/testcase'
require 'spec_helper'

RSpec.describe Boj::Testcase do
  describe '#to_str' do
    it 'testcase to str' do
      testcase = Boj::Testcase.new('testcase1', '', '')
      expect(testcase.to_s).to eq('<Testcase: testcase1>')
    end
  end
end
