# frozen_string_literal: true

require 'net/http'
require 'uri'

module Boj
  module Fetcher
    BOJ_HOST = 'https://www.acmicpc.net'

    def self.html_from(code)
      uri = URI(BOJ_HOST)
      uri.path = "/problem/#{code}"
      begin
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          request = Net::HTTP::Get.new uri
          request['user-agent'] = nil

          response = http.request request
          throw WrongResponseError.new(response.code, response.message) unless response.is_a? Net::HTTPOK

          response.body
        end
      rescue SocketError => e
        throw NetworkError e
      end
    end

    # === Errors ===
    class FetchError < StandardError
    end

    class NetworkError < FetchError
    end

    class WrongResponseError < FetchError
      def initialize(code, message)
        super "#{code}: #{message}"
      end
    end
  end
end
