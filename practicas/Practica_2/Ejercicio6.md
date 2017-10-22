# Enunciado

6. Analizá el siguiente código e indicá qué problema(s) puede tener.

   ```ruby
   # Tira un dado virtual de 6 caras
   def tirar_dado
     rand 1..6
   end

   # Mueve la ficha de un jugador tantos casilleros como indique el dado en un tablero virtual de 40 posiciones.
   # Si no se recibe la cantidad de casilleros, aprovecho el valor por defecto para ese parámetro para evitar tener que
   # llamar a #tirar_dado dentro del cuerpo del método.
   def mover_ficha(fichas, jugador, casilleros = tirar_dado)
     fichas[jugador] += casilleros
     if fichas[jugador] > 40
       puts "Ganó #{jugador}!!"
       true
     else
       puts "#{jugador} ahora está en el casillero #{fichas[jugador]}"
       fichas[jugador]
     end
   end

   posiciones = { azul: 0, rojo: 0, verde: 0 }

   finalizado = false
   until finalizado
     ['azul', 'rojo', 'verde'].shuffle.each do |jugador|
       finalizado = mover_ficha(posiciones, jugador)
     end
   end
   ```
# Solución

El codigo falla porque se crea un hash:

```ruby
posiciones = { azul: 0, rojo: 0, verde: 0 }
# => {:azul=>0, :rojo=>0, :verde=>0}
```

En el hash las claves son simbolos, y el programa itera e intenta acceder a las claves mediante strings: `['azul', 'rojo', 'verde']`

Es decir,en cualquier caso, la clave no existe

```ruby
posiciones['azul'] # => nil
posiciones['rojo'] # => nil
posiciones['verde'] # => nil
```

Deberia usarse:

```ruby
posiciones[:azul] # => integer asociado a la clave :azul
posiciones[:rojo] # => integer asociado a la clave :rojo
posiciones[:verde] # => integer asociado a la clave :verde
```