def a_ul h
  h.each_pair.reduce('<ul>') do |memo, pair|
    memo << "<li>#{pair[0]}: #{pair[1]}</li>"
  end << '</ul>'
end