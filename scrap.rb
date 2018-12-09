require_relative "string"

existing_file_name = ARGV[0]
new_file_name = ARGV[1] || "scrapbox_" + ARGV[0]
lines = ""

File.open("./" + existing_file_name) do |f|
  f.read.split("\n").each do |original_line|
    new_line = original_line.replace_bolds.replace_links.replace_headers.replace_indents
    lines += new_line + "\n"
  end
end

File.open("./" + new_file_name, "w") do |f|
  f.puts lines
end
