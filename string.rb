# Extend String class

class String
  H1 = /\#{1}\ /
  H2 = /\#{2}\ /
  H3 = /\#{3}\ /
  H4 = /\#{4}\ /
  H5 = /\#{5}\ /
  H6 = /\#{6}\ /
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

  def replace_indents(indent_type, indent_count)
    if indent_type == "space" && indent_count == 2
      i1 = /\-\ /
      i2 = /\ {2}\-\ /
      i3 = /\ {4}\-\ /
      i4 = /\ {6}\-\ /
      i5 = /\ {8}\-\ /
      i6 = /\ {10}\-\ /
    elsif indent_type == "space" && indent_count == 4
      i1 = /\-\   /
      i2 = /\ {4}\-\   /
      i3 = /\ {8}\-\   /
      i4 = /\ {12}\-\   /
      i5 = /\ {16}\-\   /
      i6 = /\ {20}\-\   /
    elsif indent_type == "tab" && indent_count == 2
      i1 = /\-\ /
      i2 = /\	{1}\-\ /
      i3 = /\	{2}\-\ /
      i4 = /\	{3}\-\ /
      i5 = /\	{4}\-\ /
      i6 = /\	{5}\-\ /
    elsif indent_type == "tab" && indent_count == 4
      i1 = /\-\ /
      i2 = /\	{2}\-\ /
      i3 = /\	{4}\-\ /
      i4 = /\	{6}\-\ /
      i5 = /\	{8}\-\ /
      i6 = /\	{10}\-\ /
    end
    [i6, i5, i4, i3, i2, i1].each do |indent|
      next self unless indent.match(self)
      replacer  = if indent == i6
                    "      "
                  elsif indent == i5
                    "     "
                  elsif  indent == i4
                    "    "
                  elsif indent == i3
                    "   "
                  elsif indent == i2
                    "  "
                  elsif indent == i1
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
