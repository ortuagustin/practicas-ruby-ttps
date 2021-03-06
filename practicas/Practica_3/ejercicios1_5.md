## Excepciones

1. Investigá la jerarquía de clases que presenta Ruby para las excepciones. ¿Para qué se utilizan las siguientes clases?
  * `IOError`: Elevada cuando una operacion de entrada/salida falla
  * `NameError`: Elevada cuando un nombre es inválido o no definido
  * `RuntimeError`: Es un error generico que se eleva cuando se intenta ejecutar una operacion inválida
  * `NotImplementedError`: Elevada cuando una característica no está implementada
  * `StopIteration`: Elevada cuando se desea frenar una iteracion, en particular  en Enumerator#next. El metodo Kernel#loop "trapea" este tipo de excepciones
  * `TypeError`: Elevada cuando un objeto no es del tipo esperado, por ej, al intentar realiar una conversión implicita
  * `SystemExit`: Elevada por #exit, para finalizar la ejecución de un script

2. ¿Cuál es la diferencia entre `raise` y `throw`? ¿Para qué usarías una u otra opción?

`raise` eleva una excepcion, la cual debe ser atendida por un manejador `rescue`

`throw` sirve para transferir el control a un bloque etiquetado usando `catch`; opcionalmente, `throw` permite pasar un valor como parametro al bloque `catch`.

`raise` deberia utilizarse para señalizar un evento de error.

`throw` y `catch` pueden ser utiles para escapar rapidamente cuando el codigo está muy anidado, esto evitaria escribir varios `break`

3. ¿Para qué sirven `begin .. rescue .. else` y `ensure`? Pensá al menos 2 casos concretos en que usarías estas
   sentencias en un script Ruby.

Son las sentencias que permiten manejar excepciones en Ruby.

`begin` indica el comienzo del bloque de codigo que se quiere proteger de excepciones

`rescue` define un manejador para algun determinado tipo de excepcion (o todas, si no se especifica). Dentro de un manejador se escriben las sentencias Ruby a ejecutar cuando ocurre la excepcion

`else` define el manejador que se ejecuta cuando ningun `rescue` matchea

`ensure` es un bloque de codigo que se ejecuta siempre, hayan ocurrido o no excepciones

4. ¿Para qué sirve `retry`? ¿Cómo evitarías caer en un loop infinito al usarla?

`retry` sirve para volver a ejecutar el bloque `begin..end`. Esto permite que podamos corregir el motivo por el cual ocurrió la excepcion y reintentar ejecutar. Para evitar caer en bucles infitinos se puede usar una bandera `boolean` o un contador para limitar el numero de veces que se ejecuta el `retry`

5. ¿Cuáles son las diferencias entre los siguientes métodos?

   ```ruby
   def opcion_1
     a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
     b = 3
     c = a.map do |x|
       x * b
     end
     puts c.inspect
   rescue
     0
   end

   def opcion_2
     c = begin
           a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
           b = 3
           a.map do |x|
             x * b
           end
         rescue
           0
         end
     puts c.inspect
   end

   def opcion_3
     a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
     b = 3
     c = a.map { |x| x * b } rescue 0
     puts c.inspect
   end

   def opcion_4
     a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
     b = 3
     c = a.map { |x| x * b rescue 0 }
     puts c.inspect
   end
   ```

* `opcion_1`: retorna 0;
* `opcion_2`: imprime `0` y retorna `nil`
* `opcion_3`: imprime `0` y retorna `nil`
* `opcion_4`: imprime `[3, 0, 9, 0, 15, 0, 21, 0, 27, 0]` y retorna `nil`