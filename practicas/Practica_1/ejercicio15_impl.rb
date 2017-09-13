class Integer
  def hex
    self.to_s(16).upcase
  end
end

def notacion_hexadecimal rgb_color
  rgb_color.reduce('') { |memo, x| memo + x.hex }.hex
end

def notacion_entera rgb_color
  rgb_color[0] + (rgb_color[1] * 256) + (rgb_color[2] * 256 * 256)
end