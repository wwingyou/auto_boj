# frozen_string_literal: true

require 'boj/problem'
require 'spec_helper'

RSpec.describe Boj::Problem do
  serialized_text = <<~TEXT
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
    solver: '283141'
  }.freeze
  p1 = Boj::Problem.new(1000, 'A+B', etc).freeze
  p2 = Boj::Problem.new(1000, 'A+B', etc).freeze
  p3 = Boj::Problem.new(1001, 'A+B', etc).freeze
  p4 = Boj::Problem.new(1000, 'A-B', etc).freeze
  p5 = Boj::Problem.new(1000, 'A+B', {}).freeze

  describe '::deserialize' do
    it 'deserialize self from string' do
      problem = Boj::Problem.deserialize(serialized_text)
      expect(problem.code).to eq('1000')
      expect(problem.title).to eq('A+B')
      expect(problem.etc[:tier]).to eq('Bronze 5')
      expect(problem.etc[:time_limit]).to eq('2 초')
      expect(problem.etc[:memory_limit]).to eq('128 MB')
      expect(problem.etc[:success_ratio]).to eq('39.319% 5')
      expect(problem.etc[:submission]).to eq('1036463')
      expect(problem.etc[:success]).to eq('410178')
      expect(problem.etc[:solver]).to eq('283147')
    end
  end

  describe '#serialize' do
    it 'serialize self to string' do
      expect(p1.serialize).to eq(serialized_text.chomp)
    end
  end

  describe '#==' do
    it 'equals to other problem only when all props are equal' do
      expect(p1).to eq(p2)
    end

    it 'not equals to other session at least one props mismatch' do
      expect(p1).not_to eq(p3)
      expect(p1).not_to eq(p4)
      expect(p1).not_to eq(p5)
    end
  end

  describe '#to_s' do
    it 'session to str' do
      str = '<Problem: 1000, A+B>'
      expect(p1.to_s).to eq(str)
    end
  end
end
