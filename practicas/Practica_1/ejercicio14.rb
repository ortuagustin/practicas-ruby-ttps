# Escribí un script en Ruby que le pida al usuario su nombre y
# lo utilice para saludarlo imprimiendo en pantalla:
# ¡Hola, <nombre>!.

puts 'Por favor, ingresá tu nombre: '
name = gets.chomp
puts "Hola, #{name}"