# frozen_string_literal: true

require 'boj/utils'
require 'spec_helper'

RSpec.describe Boj::Utils do
  describe '#normalize_newline' do
    context '$/ is \\n' do
      it 'normalize \\r\\n to \\n in text' do
        $/ = "\n"
        text = "Lorem ipsum dolor sit amet, \r\nqui minim labore adipisicing \r\nminim sint cillum sint \r\nconsectetur cupidatat."
        normalized = "Lorem ipsum dolor sit amet, \nqui minim labore adipisicing \nminim sint cillum sint \nconsectetur cupidatat."

        expect(Boj::Utils.normalize_newline(text)).to eq(normalized)
      end
    end

    context '$/ is \\r\\r' do
      it 'normalize \\n to \\r\\n in string when $/ is \\r\\n' do
        $/ = "\r\n"
        text = "Lorem ipsum dolor sit amet, \nqui minim labore adipisicing \nminim sint cillum sint \nconsectetur cupidatat."
        normalized = "Lorem ipsum dolor sit amet, \r\nqui minim labore adipisicing \r\nminim sint cillum sint \r\nconsectetur cupidatat."

        expect(Boj::Utils.normalize_newline(text)).to eq(normalized)
      end
    end
  end
end
