require "boj/environment"
require "spec_helper"

RSpec.describe Environment do
  describe "#load" do
    it "loads environment variables from file" do
      environment = Environment.load ENV_PATH
      expect(environment.default_lang).to eq("java")
      expect(environment.default_tag).to eq("solution")
    end
  end
end
