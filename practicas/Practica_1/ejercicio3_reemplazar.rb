module Reemplazar
  
  def self.reemplazar string
    result = ''
    string.each_char do |each|
      if each == '{'
        result << "do\n"
      elsif each == '}' 
        result << "\nend"
      else
        result << each
      end
    end
    result
  end
end