# TTPS opción Ruby - Práctica 5

## Rails

1. El framework está compuesto de diferentes librerías:

   Para cada una de estas librerías, analizá y respondé las siguientes preguntas:

   1. ¿Qué funcion principal cumple?
   2. ¿En qué parte(s) del patrón Model-View-Controller (MVC) encajaría?

   * **ActionMailer**: `controller`. Para generar y enviar mails
   * **ActionPack**: `controller`, `view`. Provee `ruteo`, implementado por `controladores`, los cuales renderizan las `vistas` a partir de algun `template`
   * **ActionView**: `view`. Manejo de las `vistas` y `templates`. Tambien incluye helpers para el renderizado
   * **ActiveModel**: `model`. Provee interfaces que permiten a `ActionPack` y `ActionView` interactuar con modelos que no sean `ActiveRecord`, por ej, las validaciones
   * **ActiveRecord**: `model`. Conexion con la BD, ORM
   * **ActionCable**: `controller`. Permite implementar `WebSockets` en una aplicacion Rails
   * **ActiveResource**: `model`. Para APIs REST
   * **ActiveStorage**: `model?`. Para almacenamiento cloud; permite mapearlos a clases `ActiveRecord`
   * **ActiveJob**: `controller?`. Para tareas asincronicas o procesamiento en paralelo
   * **ActiveSupport**: ninguna?. codigo y clases utilitarias, y extensiones a clases de la standart library de Ruby

2. Investigá cómo se crea una aplicación Rails nueva y enumerá los pasos básicos para tener la aplicación funcionando con una base de datos SQLite.

* El comando `rails new` crea una nueva aplicación Rails:
  ```
  $ rails new APP_PATH
  ```
* Se debe tener instalado `sqlite3`
  ```
  $ apt-get install sqlite3
  ```
* El proyecto ya funciona con una base de datos SQLite3 porque no se le pasó ningun parámetro al comando `rails new`.

3. Siguiendo los pasos que enumeraste en el punto anterior, creá una nueva aplicación Rails llamada `practica_cinco` en la cual vas a realizar las pruebas para los ejercicios de esta práctica.
4. ¿Qué es un **ambiente** (`environment`) en una aplicación Rails? ¿Qué sentido considerás que tiene usar diferentes ambientes en tu aplicación? ¿Cuál es el ambiente por defecto?

Los ambientes son las distintas configuraciones de Rails y las distintas gemas que lo componen. Por ejemplo, en `desarrollo`, tiene sentido deshabilitar el caching ya que es mas comodo para hacer pruebas; también es útil que la aplicación se recargue automáticamente al modificar algun archivo; pero esto disminuye mucho la performance y no es apropiado para un ambiente de `producción`. También permite cambiar las gemas que se van a utilizar en la aplicación, la configuración de la base de datos, el logging, el encoding por defecto, entre otras cosas

Los ambientes es una forma muy comoda de que la misma aplicación se comporte de manera distinta de acuerdo a la tarea que se debe realizar en el momento; por ejemplo, en `testing`, se puede configurar que los mails no se envien realmente; también para los tests se puede usar una base de datos SQLite3 que es simplemente un archivo y no necesita instalar un DBMS que puede consumir muchos recursos; pero esto si es adeacuado para `producción`

Rails viene por defecto con tres ambientes: `development`, `test` y `production`. El ambiente por defecto es `development`.

5. Sobre la configuración de Rails:
   1. ¿De qué forma podés especificar parámetros de configuración del framework en una app Rails?

    * Se pueden usar los distintos ambientes para configurar Rails
    * Se pueden usar variables de entorno
    * Editando el archivo `config/application.rb`
    * +Info en http://guides.rubyonrails.org/configuring.html

   2. ¿Cuáles son los archivos principales? Intentá relacionar este concepto con los ambientes que antes viste.

    * Archivos de configuración cada ambiente: `config/environment`
    * Archivos de configuración general en **/config**: `routes.rb`, `database.yml`, `application.rb`

   3. Modificá el `locale` por defecto de tu aplicación para que sea español.

    Modificar `/config/application.rb` y agregar la linea
    ```
      config.i18n.default_locale = :es
    ```

    Lo mas correcto es usando initializers, en este caso seria: /config/initializers/

    ```
      I18n.available_locales = [:es]
      I18n.default_locale = :es
    ```

   4. Modificá la zona horaria de tu aplicación para que sea la de la Argentina.

    Modificar `/config/application.rb` y agregar la linea
    ```
      config.time_zone = "Buenos Aires"
    ```

6. Sobre los *initializers*:
   1. ¿Qué son y para qué se utilizan?
   2. ¿En qué momento de la vida de la aplicación se ejecutan?

    Son archivos con código Ruby que Rails invoca después de cargar todas las gemas y plugins. Los inicializadores deben almacenarse en la carpeta `config/initializers`

   3. Si tu app está corriendo y modificás algún initializer, ¿los cambios se reflejan automáticamente? ¿Por qué?

  No, solamente se ejecutan una vez cuando la aplicación bootea

   4. Creá un initializer en tu aplicación que imprima en pantalla el string `"Booting practica_cinco"`.
      ¿En qué momento se visualiza este mensaje?


Cree un archivo en `/config/initializers/booting.rb`

```
puts "Booting practica_cinco"
```

Se visualiza en la consola:

```
=> Booting Puma
=> Rails 5.1.4 application starting in development
=> Run `rails server -h` for more startup options
Booting practica_cinco
Puma starting in single mode...
* Version 3.11.0 (ruby 2.4.1-p111), codename: Love Song
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
 ```

7. Sobre los *generators*:
   1. ¿Qué son? ¿Qué beneficios imaginás que trae su uso?

   Son plantillas para crear desde nuevas clases, migraciones, e incluso aplicaciones rápidamente. Ahorra tiempo al desarrollar ya que nos crea un esqueleto con lo básico necesario para poder empezar

   2. ¿Con qué comando podés consultar todos los generators disponibles en tu app Rails?

```
  rails generate
```

   3. Utilizando el generator adecuado, creá un controller llamado `PoliteController` que tenga una acción `salute` que responda con un saludo aleatorio de entre un arreglo de 5 diferentes, como por ejemplo *"Good day sir/ma'am."*.

```
rails generate controller PoliteController salute
```

  En la clase `app/controller/polite_controller_controller/PoliteController#salute`

```Ruby
  class PoliteControllerController < ApplicationController
    def salute
      @message = ["Good day sir/ma'am", "Hola, que tal?", "Hello world", "Aguante Rails", "Aguante Ruby"].shuffle.first
    end
  end
```

  En la vista `app/views/polite_controller/salute.html.erb`

```html
<h1>Practica 5 - Ejercicio 7.3</h1>
<p><%= @message =%></p>
```

  Acceder a: http://localhost:3000/polite_controller/salute

8. Sobre *routing*:
   1. ¿Dónde se definen las rutas de la app Rails?

  En el archivo `config/routes.rb`

   2. ¿De qué formas se pueden definir las rutas?

  Se edita el archivo `config/routes.rb`, escribiendo el código según sea necesario, usando la DSL

   3. ¿Qué ruta(s) agregó el generator que usaste antes?

  Agregó la ruta `get 'polite_controller/salute'`

   4. ¿Con qué comando podés consultar todas las rutas definidas en tu app Rails?

  `rails routes`

## ActiveSupport (AS)

1. ¿De qué forma extiende AS las clases básicas de Ruby para incorporar nuevos métodos?

  Usando monkey patching

2. Investigá qué métodos agrega AS a las siguientes clases:
   1. `String`
    1. to_date, to_time, to_datetime
    2. metodos del Inflector: tableize, classify, pluralize, singularize, etc
    3. seguridad al renderizar (para evitar injecciones) html_safe?, html_safe
    4. remove, remove!
    5. squish
    6. truncate, truncate_words
    7. at, retorna el caracter en la posicion indicada
    8. from, retorna el substring desde la posicion indicada
    9. to, retorna el substring hasta la posicion indicada
   2. `Array`
    1. to y from. Devuelven n elementos desde el inicio/fin del arreglo respectivamente
    2. prepend. Agrega al principio
    3. append. Agrega al final. Alias de <<
    4. extract_options!
    5. to_sentence
    6. to_xml
    7. in_groups, in_groups_of
   3. `Hash`
    1. to_xml
    2. reverse_merge, reverse_merge!
    3. deep_merge, deep_merge!
    4. except, except!
    5. transform_keys, transform_keys!, transform_values, transform_values!
    6. stringify_keys, stringify_keys!
    7. symbolize_keys, symbolize_keys!
    8. slice, slice!
    9. extract!
    10. assert_valid_keys
    11. compact
    12. with_indifferent_access
   4. `Date`
    1. Date.current: Es como Date.today, pero respetando la zona horaria
    2. Date.yesterday y Date.tomorrow
    3. past?, today?, future?, on_weekday?, on_weekend?. Todos relativos a Date.current
    4. beginning_of_week, end_of_week
    5. monday, sunday. Devuelven la fecha del lunes anterior/próximo domingo
    6. xxx_ago y xxx_since, por ejemplo: years_ago, years_since
   5. `Numeric`
    1. bytes, kilobytes, megabytes, gigabytes, terabytes, petabytes, exabytes
    2. se permite usar "tiempo" para hacer calculos, por ej: 1.month.from_now, 2.years.from_now, (4.months + 5.years).from_now
    3. formateo: to_s(:phone), to_s(:currency), to_s(:percentage), to_s(:delimited), to_s(:rounded), etc
3. ¿Qué hacen y en qué clase define AS los siguientes métodos?
   1. `blank?` los siguientes objetos devuelven true al invocarse este metodo: nil, false, strings vacios o compuestos por blancos, array vacios, hashes vacios, o cualquier objeto que responda a empty? y evalue true. Definido en Object
   2. `present?` La documentacion dice que es lo mismo que !blank?. Definido en Object
   3. `presence` Devuelve el receptor si present? evalua a true; nil en caso contrario. Definido en Object
   4. `try` Invoca al metodo que se recibe como parametro (en forma de simbolo) solo si el receptor no es nil. Evita checkeos por nil. Definido en Object
   5. `in?` Evalua si el objeto esta incluido en otro. Definido en Object
   6. `alias_method_chain` Se usa cuando se quiere agregar una caracteristica a un metodo, pero tambien proveer, con un nombre distinto (gralmente. nombre_metodo_without_feature) el metodo original. Esto se puede hacer en Ruby usando alias_method, pero es necesario invocarlo dos veces; alias_method_chain permite hacerlo en una linea. Como resultado, quedan 3 metodos, por ej: foo, foo_with_feature, foo_without_feature. Definido en Module
   7. `delegate` Permite reenviar o redireccionar metodos. Definido en Module
   8. `pluralize` Retorna el plural de su receptor. Definodo en String
   9. `singularize` Inverso de pluralize. Definodo en String
   10. `camelize` Retorna el receptor en CamelCase. Definodo en String
   11. `underscore` Retorna el receptor en snake_case. Definodo en String
   12. `classify` El inverso de tableize. Retorna el nombre de la clase Ruby que representa la tabla de la bd. Ej "people".classify # => "Person". Definodo en String
   13. `constantize` Definido en String
   14. `humanize` Retorna el nombre del atributo de modo tal que sea apropiado para un usuario final (elimina sufjos _id, transforma guion bajo en espacios en blanco, elimina guiones bajos al inicio, etc). Definido en String
   15. `sum`. Suma todos los elementos del Enumerable, enviando el mensaje :+ Definido en Enumerable
4. ¿De qué manera se le puede *enseñar* a AS cómo pasar de singular a plural (o viceversa) los sustantivos que usamos  en nuestro código?

   > Tip: Mirá el archivo config/initializers/inflections.rb

  Se hace con expresiones regulares, las cuales se deben agregar en `config/initializers/inflections.rb`

5. Modificá la configuración de la aplicación Rails para que *aprenda* a pluralizar correctamente en español todas las palabras que terminen en `l`, `n` y `r`.

   > Tip: el uso de expresiones regulares simples ayuda. :)

## ActiveRecord (AR)

1. ¿Cómo se define un modelo con ActiveRecord? ¿Qué requisitos tienen que cumplir las clases para utilizar la lógica de abstracción del acceso a la base de datos que esta librería ofrece?

  Se debe definir una subclase de `ActiveRecord::Base`, o más recientemente en Rails, `ApplicationRecord`. Los modelos (tanto las clases Ruby como las tablas en la base de datos) deben seguir una serie de normas o convenciones, sobre todo en los nombres de las clases, las tablas, y los atributos o campos de las mismas. para que el mapeo funcione correctamente (aunque también es posible configurarlo manualmente)

2. ¿De qué forma *sabe* ActiveRecord qué campos tiene un modelo?

  Inspeccionando la tabla a la que esta asociado en la base de datos, puede obtener el nombre de las columnas y crear dinamicamente los accesors para el modelo

3. ¿Qué metodos (*getters* y *setters*) genera AR para los campos escalares básicos (`integer`, `string`, `text`, `boolean`, `float`)?

  Genera un getter y setter con el nombre del campo según cómo esté definido en la BD, es decir, `<attribute>` y `<attribute>=`. Además, agrega también `<attribute>?`, que sirve para determinar si el atributo está presente o no

  Tambien existen los valores raw de los atributos antes de que sean castedos segun el tipo de campo. Estos se pueden acceder con los accessors `<attribute>_before_type_cast`

4. ¿Qué convención define AR para inferir los nombres de las tablas a partir de las clases Ruby? Citá ejemplos.

  La convención es, se `singulariza` el nombre de la clase Ruby, y despues lo pasa a `snake_case`. Ejemplos:
  * `Product` --> `products`
  * `PostComment` --> `post_comments`
  * `SystemSetting` --> `system_settings`

5. Sobre las migraciones de AR:
   1. ¿Qué son y para qué sirven?

    Son una DSL que permiten modificar la estructura de una base de datos a lo largo del tiempo, de manera facil y consistente. Evita tener que escribir SQL directamente, (son independientes del motor SQL subyacente). Esto permite "versionar" de alguna manera, el esquema de la base de datos. Es posible moverse "para adelante" o "para atrás" en este esquema, en cualquier momento. ActiveRecord tiene implementada la lógica necesaria para saber que migración aplicó, y también sabe deshacerlas

   2. ¿Cómo se generan?
   3. ¿Dónde se guardan en el proyecto?
   4. ¿Qué organización tienen sus nombres de archivo?

    Se crea un archivo de código Ruby, se subclasea `ActiveRecord::Migration` y se implementa el método `change` (en algunos casos se debe implementar los metodos `up` y `down` en lugar de `change`). La manera más conveniente de crear una nueva migración es usando un generador: `rails generate migration`

    Se almacenan en el directorio `db/migrate`

    El nombre del archivo debe comenzar con el `timestamp` de cuando fue creada la migración, esto permite aplicarlas en el orden correcto, y además, desde "dónde" comenzar a aplicar las migraciones; luego del timestamp y seguido de un guion bajo, va el nombre de la migración, que debe coincidir con el nobmre de la clase que implementa dicha migración. Ejemplo:

    YYYYMMDDHHMMSS_create_products.rb --> CreateProducts < ActiveRecord::Migration [...]

   5. Generá una migración que cree la tabla `offices` con los siguientes atributos:
      * `name`: `string` de `255` caracteres, no puede ser nulo.
      * `phone_number`: `string` de `30` caracteres, no puede ser nulo.
      * `address`: `text`.
      * `available`: `boolean`, por defecto `false`, no puede ser nulo.
5. Creá el modelo `Office` para la tabla `offices` que creaste antes, e implementale el método `#to_s`.
6. Utilizando migraciones, creá la tabla y el modelo para la clase `Employee`, con la siguiente estructura:
   * `name`: `string` de `150` caracteres, no puede ser nulo.
   * `e_number`: `integer`, no puede ser nulo, debe ser único.
   * `office_id`: `integer`, foreign key hacia `offices`.
7. Agregá una asociación entre `Employee` y `Office` acorde a la columna `office_id` que posee la tabla `employees`.
   1. ¿Qué tipo de asociación declaraste en la clase `Employee`?

    belongs_to :office

   2. ¿Y en la clase `Office`?

    Nada

   3. ¿Qué métodos generó AR en el modelo a partir de esto?

    Nada, aunque los accessors los va a generar dinamicamente

   4. Modificá el mapeo de rutas de tu aplicación Rails para que al acceder a `/` se vaya al controller definido antes (`polite#salute`).

```Ruby
  Rails.application.routes.draw do
    root to: 'polite#salute'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
```

8. Sobre *scopes*:
   1. ¿Qué son los scopes de AR? ¿Para qué los utilizarías?

  Consiste en encapsular en un metodo de una clase, una consulta al modelo, de modo tal que sea mas facil reutilizarla; evita tener que reescribir las diferentes condiciones (where) y joins. Es útil para consultas que son comunes. Los scopes tambien son anidables entre si, y también se puede continuar encadenando metodos `where`, `join`, etc

  Ejemplo en http://guides.rubyonrails.org/active_record_querying.html#scopes

   2. Investigá qué diferencia principal existe entre un método estático y un scope.

  Los scopes siembre deben retornar un objeto de tipo `ActiveRecord::Relation`. Esto puede causar problemas si se usan condicionales. Si se utiliza `scope`, esto es manejado automáticamente, mientras que un metodo de clase podría retornar `nil`

   3. Agregá los siguientes scopes al modelo `Employee`:
      * `vacant`: Filtra los empleados para quedarse únicamente con aquellos que no tengan una oficina asignada (*asociada*).
      * `occupied`: Complemento del anterior, devuelve los empleados que sí tengan una oficina asignada.
   4. Agregá este scope al modelo `Office`:
      * `empty`: Devuelve las oficinas que están disponibles (`available = true`) que no tienen empleados asignados.
9. Sobre *scaffold controllers*:
   1. ¿Qué son? ¿Qué operaciones proveen sobre un modelo?

  Son controladores que ya asumen que el modelo existe, por eso el generador `scaffold_controller` no crea el modelo ni su migracion. Crea un recurso RESTful, con los 7 metodos en el controlador, asi como tambien las vistas necesarias. No genera las rutas

   2. ¿Con qué comando se generan?

  rails g scaffold_controller

   3. Utilizando el generator anterior, generá un controlador de scaffold para el modelo `Office` y otro para el modelo
      `Employee`.

  rails g scaffold_controller Office
  rails g scaffold_controller Employee

   4. ¿Qué rutas agregó este generator?

  Ninguna

   5. Analizá el código que se te generó para los controllers y para las vistas, y luego modificalo para que no permita
      el borrado de ninguno de los elementos. ¿Qué cambios debés hacer para que las vistas no muestren la opción, el
      controller no tenga la acción `destroy` y las rutas de borrado dejen de existir en la aplicación?

  Se debe eliminar los metodos `#destroy` de los controllers
  Se debe eliminar la linea que contiene `link_to 'Destroy'` de las vistas `index.html.erb`

## ActiveModel (AM)

1. ¿Qué son los validadores de AM?

  Se usan para chequear el estado de los modelos antes de que estos sean persistidos en la BD. Los métodos de persistencia (create, save, update) las ejecutan, y si alguna falla, el modeo no se persiste y los métodos nombrados devuelven false. Esto permite garantizar que siempre guarden datos válidos en la BD (ojo, hay métodos que no consideran las validaciones!! --> ver https://ttps-ruby.github.io/teoria/#/18/33)
  Los metodos #valid? e #invalid? ejecutarán las validaciones
  Se puede acceder al atributo #errors de un modelo para consular las validaciones que fallaron; el atributo #errors.messages es la coleccoion los mensajes de error, indexada por el campo (atributo del modelo) con errores.

2. Agregá a los modelos `Office` y `Employee` las validaciones necesarias para hacer que sus atributos cumplan las restricciones definidas para las columnas de la tabla que cada uno representa.
3. Validadores personalizados:
    1. ¿Cómo podés definir uno para tus modelos AR?

  Hay varias formas de hacerlo, usando las opciones `:if` o `:unless`
  - Indicando, con un simbolo, el nombre del metodo que el validador debe ejecutar
  - Pasandole un `proc`, para definir el comportamiento del validador sin la necesidad de crear un método
  - Un string que se interpretará como código Ruby
  - Un array, que combina múltiples condiciones

  Ejemplos en
  >http://guides.rubyonrails.org/active_record_validations.html#conditional-validation

  >https://ttps-ruby.github.io/teoria/#/18/47

  Tambien es posible usar clases dedicadas que implementan la lógica de validación. Esto se hace subclaseando `ActiveModel::Validator`. Esta clase deberá implementar el método `validate(record)`. En el modelo, se debe indicar que se utiliza un validador personalizado usando `validates_with NombreClaseValidador`

  >http://guides.rubyonrails.org/active_record_validations.html#custom-validators

  Por último, existe la posibilidad de definir métodos de validación en el modelo, que además agregan mensajes en la coleccion #errors. Estos métodos deben registrarse usando el metodo de clase `validate` y la lista de simbolos que corresponde a los métodos de validación

 > http://guides.rubyonrails.org/active_record_validations.html#custom-methods

    2. Implementá un validador que chequee que un string sea un número telefónico con un formato válido para la
       Argentina.
    3. Agregá el validador que definiste en el punto anterior a tu modelo `Office` para validar el campo `phone_number`.

## Internacionalización (i18n) y localización (l10n)

1. ¿A qué hacen referencia estos conceptos?

  **Localización**: Es la adaptación del software para que contemple los aspectos del lenguaje, cultura y otros requisitos de un mercado(`locale`) específico. Esto implica más que traducir la interfaz de usuario, ya que debe tener en cuenta: formato de números, fechas, horas, moneda, teclado, collation, simbolos, colores, iconos, asi como también la adaptación de textos o imagenes que en determinada cultura puedan ser interpretados de manera equívocada o sean incluso ofensivos, requerimientos legales, fechas, dias u eventos especiales, entre muchas mas cosas

  **Internacionalización**: Es una forma de diseñar y desarrollar el software de modo tal que sea **posible** `localizar` fácilmente el contenido, dependiendo de los usuarios del software, que pueden variar en su cultura, región o idioma

  https://blog.mozilla.org/l10n/2011/12/14/i18n-vs-l10n-whats-the-diff/
  https://www.w3.org/International/questions/qa-i18n

2. Investigá qué dos metodos provee la clase `I18n` para realizar la traducción (i18n) y la localización (l10n).

  Hay dos métodos que provee la `API I18n`:
  * **translate** # Lookup text translations. Tiene un alias, `I18n.t`
  * **localize**  # Localize Date and Time objects to local formats. Tiene un alias, `I18n.l`

  Existen una serie de atributos más para configurar la internacionalización, ver

  > http://guides.rubyonrails.org/i18n.html#the-public-i18n-api

3. Modificá el controller `PoliteController` que creaste antes para que utilice traducciones al imprimir el mensaje de saludo.
4. Modificá los controllers de scaffold que generaste para que utilicen i18n, tanto en las vistas como en los mensajes flash del controller.

   > Tip: Investigá qué helper provee Rails en las vistas para las traducciones.

   Los helper son: `translate` y su alias `t`; `localize` y su alias `l`
   <%=t :symbol %>

## Referencias

* Ruby on Rails - http://rubyonrails.org
  * [APIs](http://api.rubyonrails.org/)
  * [Guías](http://guides.rubyonrails.org/)
  * [Guía básica de ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html)
  * [Extensiones de ActiveSupport](http://guides.rubyonrails.org/active_support_core_extensions.html)
  * [Rails for Zombies](http://railsforzombies.org/) (Un poco desactualizado, pero vale la pena mencionarlo)
