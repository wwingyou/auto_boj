# frozen_string_literal: true

module Boj
  class Configuration < Hash
    DEFAULTS = { 
      "archive_path"      => "archive",
      "stage_path"        => "stage",
      "archive_format"    => "[%code%] %title%",
      "default_tag"       => "solution",
      "default_language"  => "java",
      "default_post_name" => "README.md",

      "testcase"          => {
        "default_file_name"   => "testcase.txt",
        "input_prefix"        => "==",
        "output_prefix"       => "=>",
        "default_name_format" => "테스트 $",
      },

      "exe"               => {
        "java"          => "java %file%",
        "python"        => "python %file%",
      },
    }.each_with_object(Configuration.new) { |(k, v), hash| hash[k] = v.freeze }.freeze

    class << self
      def load
        #TODO: 설정파일을 이용해서 기본설정 변경할 수 있도록 하기
        DEFAULTS
      end
    end
  end
end
