require 'thor'
require_relative "string"
require "optparse"

module MarkdownToScrapbox
  class CLI < Thor
    default_command :convert
    desc "convert params", "hoge~"
    def convert(params)
      parse_params(params)
      lines = ""
      
      File.open("./" + @existing_file_name) do |f|
        f.read.split("\n").each do |original_line|
          new_line = original_line.replace_bolds.replace_links.replace_headers.replace_indents(@indent_type, @indent_count)
          lines += new_line + "\n"
        end
      end
      
      File.open("./" + @new_file_name, "w") do |f|
        f.puts lines
      end
    end

    private
    def parse_params(params)
      @existing_file_name = params["i"] || params["input"]
      @new_file_name = params["o"] || params["output"] || "scrapbox_" + @existing_file_name
      @indent_type = params["t"] || params["type-of-indent"] || "space"
      @indent_count = (params["c"] || params["count-of-indent"] || "2").to_i
    end
  end
end