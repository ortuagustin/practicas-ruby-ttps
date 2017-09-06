module ContarPalabras

    def self.contar str, substr
      words = str.downcase.split
      words.count { |s| s == substr }
    end
  end