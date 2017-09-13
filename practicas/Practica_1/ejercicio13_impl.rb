def rot string, positions
  lowercase = [*'a'..'z']
  upcase = [*'A'..'Z']
  alphabet = (upcase + lowercase)
  rot_alphabet = (upcase.rotate positions) + (lowercase.rotate positions)
  string.tr alphabet.join, rot_alphabet.join
end