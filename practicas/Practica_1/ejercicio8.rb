# ¿Qué hace el siguiente código?

[:upcase, :downcase, :capitalize, :swapcase].map do |meth|
  "TTPS Ruby".send(meth)
end

# Crea un arreglo con una lista de simbolos
# Itera el arreglo y le envia el mensaje a un objeto string
# El resultado de la ejecucion seria:
# => "TTPS RUBY"
# => "ttps ruby"
# => "Ttps ruby"
# => "ttps rUBY"