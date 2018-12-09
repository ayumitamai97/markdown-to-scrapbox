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
    rep_h1.rep_h2.rep_h3.rep_h4.rep_h5.rep_h6
  end

  def replace_indents
    rep_i6.rep_i5.rep_i4.rep_i3.rep_i2.rep_i1
  end

  def replace_bolds
    return self unless BOLD.match(self)
    sub!(BOLD, "[[").sub!(BOLD, "]]")
  end

  def replace_links
    return self unless LINK.match(self)
    gsub!(/\]\(|\)/, "](" => " ", ")" => "]")
  end

  def rep_h1
    return self unless H1.match(self)
    gsub!(H1, "[****** ") + "]"
  end
  def rep_h2
    return self unless H2.match(self)
    gsub!(H2, "[***** ") + "]"
  end
  def rep_h3
    return self unless H3.match(self)
    gsub!(H3, "[**** ") + "]"
  end
  def rep_h4
    return self unless H4.match(self)
    gsub!(H4, "[*** ") + "]"
  end
  def rep_h5
    return self unless H5.match(self)
    gsub!(H5, "[** ") + "]"
  end
  def rep_h6
    return self unless H6.match(self)
    gsub!(H6, "[* ") + "]"
  end

  def rep_i1
    return self unless I1.match(self)
    gsub!(I1, " ")
  end
  def rep_i2
    return self unless I2.match(self)
    gsub!(I2, "  ")
  end
  def rep_i3
    return self unless I3.match(self)
    gsub!(I3, "   ")
  end
  def rep_i4
    return self unless I4.match(self)
    gsub!(I4, "    ")
  end
  def rep_i5
    return self unless I5.match(self)
    gsub!(I5, "     ")
  end
  def rep_i6
    return self unless I6.match(self)
    gsub!(I6, "      ")
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
