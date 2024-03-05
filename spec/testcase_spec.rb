# frozen_string_literal: true

require 'boj/testcase'
require 'spec_helper'

RSpec.describe Boj::Testcase do
  t1_fp = File.expand_path('_source/testcase/t1.txt', __dir__)
  t1 = Boj::Testcase.new('테스트1', '1 2', '3')
  t2 = Boj::Testcase.new('테스트1', '1 2', '3')

  describe '#serialize' do
    it 'serialize testcase' do
      serialized_text = <<~TEST
        ==테스트1
        1 2
        =>
        3
      TEST
      expect(t1.serialize).to eq(serialized_text.chomp)
    end
  end

  describe '::deserialize' do
    it 'deserialize testcase' do
      source = File.read(t1_fp)
      deserialized_testcase = Boj::Testcase.deserialize(source)
      expect(deserialized_testcase.tag).to eq('테스트1')
      expect(deserialized_testcase.input).to eq('1 2')
      expect(deserialized_testcase.output).to eq('3')
    end
  end

  describe '#==' do
    it 'return true if all props are equal' do
      expect(t1).to eq(t2)
    end
  end

  describe '#to_str' do
    it 'testcase to str' do
      expect(t1.to_s).to eq('<Testcase: testcase1>')
    end
  end
end
