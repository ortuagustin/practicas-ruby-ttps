# El codigo falla porque se crea un hash:

posiciones = { azul: 0, rojo: 0, verde: 0 }
# => {:azul=>0, :rojo=>0, :verde=>0}

# En el hash las claves son simbolos, y el programa itera e intenta acceder a
# las claves mediante strings: ['azul', 'rojo', 'verde']

# Es decir,en cualquier caso, la clave no existe

posiciones['azul']
posiciones['rojo']
posiciones['verde']

# => nil

# Deberia usarse

posiciones[:azul]
posiciones[:rojo]
posiciones[:verde]