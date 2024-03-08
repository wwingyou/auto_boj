# frozen_string_literal: true

require 'boj/session'
require 'spec_helper'

RSpec.describe Boj::Session do
  serialized_text = <<~TEXT
    1000
    java
    solution
    not_started
  TEXT
  s1 = Boj::Session.new('1000', 'java', 'solution', :not_started).freeze
  s2 = Boj::Session.new('1000', 'java', 'solution', :not_started).freeze
  s3 = Boj::Session.new('2000', 'java', 'solution', :not_started).freeze
  s4 = Boj::Session.new('1000', 'python', 'solution', :not_started).freeze
  s5 = Boj::Session.new('1000', 'java', 'dijkstra', :not_started).freeze
  s6 = Boj::Session.new('1000', 'java', 'solution', :success).freeze

  describe '::deserialize' do
    it 'deserialize self from .session file' do
      session = Boj::Session.deserialize(serialized_text)
      expect(session.pcode).to eq('1000')
      expect(session.language).to eq('java')
      expect(session.tag).to eq('solution')
      expect(session.status).to eq(:not_started)
    end
  end

  describe '#serialize' do
    it 'serialize self to string' do
      expect(s1.serialize).to eq(serialized_text.chomp)
    end
  end

  describe '#==' do
    it 'equals to other session only when all props are equal' do
      expect(s1).to eq(s2)
    end

    it 'not equals to other session at least one props mismatch' do
      expect(s1).not_to eq(s3)
      expect(s1).not_to eq(s4)
      expect(s1).not_to eq(s5)
      expect(s1).not_to eq(s6)
    end
  end

  describe '#to_s' do
    it 'session to str' do
      str = '<Session: 1000, java, solution, not_started>'
      expect(s1.to_s).to eq(str)
    end
  end
end
