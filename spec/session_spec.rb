# frozen_string_literal: true

require 'boj/session'
require 'spec_helper'

RSpec.describe Boj::Session do
  it 'deserialize self from .session file' do
    serialized_text = File.read(File.expand_path('_source/.session', __dir__))
    session = Session.deserialize(serialized_text)
    expect(session.code).to eq('1000')
    expect(session.language).to eq('java')
    expect(session.tag).to eq('solution')
    expect(session.status).to eq(:not_started)
  end

  it 'serialize self to string' do
    session = Session.new('1000', 'java', 'solution', :not_started)
    serialized_text = <<~TEXT
      1000
      java
      solution
      not_started
    TEXT
    expect(session.serialize).to eq(serialized_text)
  end
end
