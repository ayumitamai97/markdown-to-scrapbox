require "pry"
class String # Stringクラスを拡張
  H1 = /\#{1}\ /
  H2 = /\#{2}\ /
  H3 = /\#{3}\ /
  H4 = /\#{4}\ /
  H5 = /\#{5}\ /
  H6 = /\#{6}\ /
  I1 = /\-\   /
  I2 = /\ {4}\-\   /
  I3 = /\ {8}\-\   /
  I4 = /\ {12}\-\   /
  I5 = /\ {16}\-\   /
  I6 = /\ {20}\-\   /
  BOLD = /\*\*/
  LINK = /\[.+\]\(.+\)/

  def replace_headers
    [H6, H5, H4, H3, H2, H1].each do |header|
      next self unless header.match(self)
      replacer  = if header == H6
                    "[* "
                  elsif header == H5
                    "[** "
                  elsif header == H4
                    "[*** "
                  elsif header == H3
                    "[**** "
                  elsif header == H2
                    "[***** "
                  elsif header == H1
                    "[****** "
                  end
      return self.gsub!(header, replacer) + "]"
    end
    return self
  end

  def replace_indents
    [I6, I5, I4, I3, I2, I1].each do |indent|
      next self unless indent.match(self)
      replacer  = if indent == I6
                    "      "
                  elsif indent == I5
                    "     "
                  elsif  indent == I4
                    "    "
                  elsif indent == I3
                    "   "
                  elsif indent == I2
                    "  "
                  elsif indent == I1
                    " "
                  end
      return self.gsub!(indent, replacer)
    end
    return self
  end

  def replace_bolds
    return self unless BOLD.match(self)
    sub!(BOLD, "[[").sub!(BOLD, "]]")
  end

  def replace_links
    return self unless LINK.match(self)
    gsub!(/\]\(|\)/, "](" => " ", ")" => "]")
  end
end

existing_file_name = ARGV[0]
new_file_name = ARGV[1] || "scrapbox_" + ARGV[0]
lines = ""

File.open("./" + existing_file_name) do |f|
  f.read.split("\n").each do |original_line|
    new_line = original_line.replace_bolds.replace_links.replace_headers.replace_indents
    lines += new_line + "\n"
  end
end

File.open("./"+new_file_name, "w") do |f|
  f.puts lines
end
