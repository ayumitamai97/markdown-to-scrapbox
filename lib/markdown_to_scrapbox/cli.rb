require 'thor'
require_relative "string"
require "optparse"

module MarkdownToScrapbox
  class CLI < Thor
    default_command :convert

    desc "convert params",
      "provide input file, output file, indent type and the number of indent with options"
    def convert(params)
      parse_params(params)
      validate_params(@output_file_name, @indent_type, @indent_count)

      lines = ""
      File.open("./" + @input_file_name) do |f|
        f.read.split("\n").each do |original_line|
          new_line = original_line
                     .replace_bolds
                     .replace_links
                     .replace_headers
                     .replace_indents(@indent_type, @indent_count)
          lines += new_line + "\n"
        end
      end
      
      File.open("./" + @output_file_name, "w") do |f|
        f.puts lines
      end
    end

    private
    def parse_params(params)
      @input_file_name = params["i"] || params["input"]
      validate_input_file_name(@input_file_name)
      input_file_name_without_ext = @input_file_name.delete(".md")
      @output_file_name = params["o"] || params["output"] ||
                          "scrapbox_" + input_file_name_without_ext + ".txt"
      @indent_type = params["t"] || params["type-of-indent"] || "space"
      @indent_count = (params["c"] || params["count-of-indent"] || "2").to_i
    end

    def validate_input_file_name(input_file_name)
      if input_file_name.nil? || !input_file_name.match(/.+\.md/)
        error "Input file name should be markdown file (*.md) ."
        exit 
      end
    end

    def validate_params(output_file_name, indent_type, indent_count)
      unless output_file_name.match(/.+\.txt/)
        warn "Warning: In order not to auto-format output file when you open it,"
        warn "it is recommended that you specify output file as text file (*.txt) ."
      end
      unless indent_type == "space" || indent_type == "tab"
        error "Indent type should be either space or tab."
        exit
      end
      unless indent_count === 2 || indent_count === 4
        error "The number of indent should be either 2 or 4."
        exit
      end
    end

    def error(msg)
      STDERR.puts "Error: " + msg
    end
  end
end