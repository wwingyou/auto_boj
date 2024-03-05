# frozen_string_literal: true

require 'boj/session'
require 'spec_helper'

RSpec.describe Boj::Session do
  it 'deserialize self from .session file' do
    serialized_text = File.read(File.expand_path('_source/.session', __dir__))
    session = Boj::Session.deserialize(serialized_text)
    expect(session.pcode).to eq('1000')
    expect(session.language).to eq('java')
    expect(session.tag).to eq('solution')
    expect(session.status).to eq(:not_started)
  end

  it 'serialize self to string' do
    session = Boj::Session.new('1000', 'java', 'solution', :not_started)
    serialized_text = <<~TEXT
      1000
      java
      solution
      not_started
    TEXT
    expect(session.serialize).to eq(serialized_text.chomp)
  end

  describe '#==' do
    it 'equals to other session only when all props are equal' do
      s1 = Boj::Session.new('1000', 'java', 'solution', :not_started)
      s2 = Boj::Session.new('1000', 'java', 'solution', :not_started)
      expect(s1).to eq(s2)
    end

    it 'not equals to other session at least one props mismatch' do
      s1 = Boj::Session.new('1000', 'java', 'solution', :not_started)
      s2 = Boj::Session.new('2000', 'java', 'solution', :not_started)
      s3 = Boj::Session.new('1000', 'python', 'solution', :not_started)
      s4 = Boj::Session.new('1000', 'java', 'dijkstra', :not_started)
      s5 = Boj::Session.new('1000', 'java', 'solution', :success)
      expect(s1).not_to eq(s2)
      expect(s1).not_to eq(s3)
      expect(s1).not_to eq(s4)
      expect(s1).not_to eq(s5)
    end
  end

  describe '#to_s' do
    it 'session to str' do
      session = Boj::Session.new('1000', 'java', 'solution', :not_started)
      str = '<Session: 1000, java, solution, not_started>'
      expect(session.to_s).to eq(str)
    end
  end
end
