# frozen_string_literal: true

module Boj
  class TestcaseIO
    attr_reader :file_path, :input_prefix, :output_prefix, :name_format,
                :input_prefix_match, :output_prefix_match

    def initialize(path = nil)
      path ||= Boj.config['stage_path']
      testcase_config = Boj.config['testcase']
      @file_path = "#{path}/#{testcase_config['default_file_name']}"
      @input_prefix = testcase_config['input_prefix']
      @output_prefix = testcase_config['output_prefix']
      @name_format = testcase_config['default_name_format']
      @input_prefix_match = Regexp.new("^#{input_prefix}(.*)$")
      @output_prefix_match = Regexp.new("^#{output_prefix}\\s*$")
    end

    def write(testcase)
      handle_file_error(file_path) do
        File.open(file_path, 'w') do |file|
          (0...testcase.size).each do |index|
            file.puts "#{input_prefix}#{testcase[index].tag}"
            file.puts testcase[index].input
            file.puts output_prefix
            file.puts testcase[index].output
          end
        end
      end
    end

    def read
      result = []
      handle_file_error(file_path) do
        File.open(file_path, 'r') do |file|
          tag = nil
          input = nil
          output = nil
          begin
            # 첫 번째 헤더 찾기
            while file.readline !~ input_prefix_match
            end
            while true
              tag = ::Regexp.last_match(1).strip
              # 인풋 읽기
              input = ''
              while line = file.readline
                break if line =~ output_prefix_match

                input += line
              end
              # 아웃풋 읽기
              output = ''
              while line = file.readline
                break if line =~ input_prefix_match

                output += line
              end
              result << Testcase.new(tag, input, output)
            end
          rescue EOFError
            if !tag.nil? and !input.nil? and !output.nil?
              result << Testcase.new(tag, input, output)
            elsif !(tag.nil? and input.nil? and output.nil?)
              throw InvalidFormatError.new(file_path)
            end
          end
        end
      end
      result
    end

    private

    def handle_file_error(file_path, &block)
      block.call if block_given?
    rescue Errno::ENOENT
      throw NoFileError.new(file_path)
    rescue Errno::EACCES
      throw FileAccessError.new(file_path)
    end

    # ====================================
    #               Errors
    # ====================================
    class TestcaseIOError < StandardError
      attr_reader :file_path

      def initialize(file_path)
        @file_path = file_path
        super set_message
      end

      def set_message
        nil
      end
    end

    class NoFileError < TestcaseIOError
      def set_message
        super "'#{file_path}' not exists", file_path
      end
    end

    class FileAccessError < TestcaseIOError
      def set_message
        super "access denied '#{file_path}'", file_path
      end
    end

    class InvalidFormatError < TestcaseIOError
      def set_message
        super "invalid format '#{file_path}'", file_path
      end
    end
  end
end
