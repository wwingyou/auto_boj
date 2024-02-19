require "boj/session"
require "spec_helper"


RSpec.describe Session do
  describe "#new" do
    it "creates session with given data" do
      session = create_session
      validate_session session
    end
  end

  describe "#save" do
    it "saves session to file" do
      if File.exist?(SESSION_PATH)
        File.delete SESSION_PATH 
      end
      session = create_session
      session.save SESSION_PATH
      saved_session = Session.load SESSION_PATH
      validate_session saved_session
    end
  end

  describe "#load" do
    it "loads session data from .boj file" do
      session = Session.load SESSION_PATH
      validate_session session
    end

    it "loads nil if file doesn't exit" do
      nil_session = Session.load NOT_EXISTS_PATH
      expect(nil_session).to eq(nil)
    end
  end

  describe "#==" do
    it "returns equality to other session" do
      base = Session.new("1000", "java", "solution")
      equal = Session.new("1000", "java", "solution")
      code_not_equal = Session.new("1001", "java", "solution")
      language_not_equal = Session.new("1000", "python", "solution")
      tag_not_equal = Session.new("1000", "java", "dijkstra")

      expect(base).to eq(equal)
      expect(base).not_to eq(code_not_equal)
      expect(base).not_to eq(language_not_equal)
      expect(base).not_to eq(tag_not_equal)
    end

    it "returns false when ohter is not session" do
      base = Session.new("1000", "java", "solution")
      expect(base).not_to eq("session")
      expect(base).not_to eq(nil)
    end
  end

  describe "#checkout" do
    it "create new session with new value" do
      base = Session.new("1000", "java", "solution")
      s1 = base.checkout(code: "1001")
      s2 = base.checkout(language: "python")
      s3 = base.checkout(tag: "dijkstra")
      s4 = base.checkout(code: "1001", language: "python", tag: "dijkstra")
      expect(s1).to eq(Session.new("1001", "java", "solution"))
      expect(s2).to eq(Session.new("1000", "python", "solution"))
      expect(s3).to eq(Session.new("1000", "java", "dijkstra"))
      expect(s4).to eq(Session.new("1001", "python", "dijkstra"))
    end
  end
end

def create_session 
  Session.new("1000", "java", "solution")
end

def validate_session(session)
  expect(session.code).to eq("1000")
  expect(session.language).to eq("java")
  expect(session.tag).to eq("solution")
end
