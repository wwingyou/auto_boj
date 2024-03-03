# frozen_string_literal: true

require 'nokogiri'

module Boj
  module Parser
    TAG_PREFIX = '테스트'

    def self.problem_from(html)
      page = Nokogiri::HTML(html)
      page.css('a[href^="/problem/"]').each do |e|
        break if e.content =~ /^(\d+)번$/
      end
      code = ::Regexp.last_match(1).to_i
      title = page.at_css('span#problem_title').content
      description = page.at_css('div#problem_description').content
      testcase = []
      number = 1
      while true
        input = page.at_css("pre#sample-input-#{number}")
        output = page.at_css("pre#sample-output-#{number}")

        break if input.nil? or output.nil?

        normalized_input = Boj::Utils.normalize_newline input.content
        normalized_output = Boj::Utils.normalize_newline output.content

        testcase << Testcase.new("#{TAG_PREFIX} #{number}", normalized_input, normalized_output)
        number += 1
      end

      Problem.new(code, title, description, testcase)
    end
  end
end
