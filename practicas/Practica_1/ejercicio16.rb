# Investigá qué métodos provee Ruby para:

# Conocer la lista de métodos de una clase.

El metodo es Object::methods

Este retorna un Array con los nombres de los metodos publicos y protegidos
Tiene un parametro opcional que si se setea a false devuevle los metodos de clase

# Conocer la lista de métodos de instancia de una clase.

El metodo es Module::instance_methods

Este retorna un Array con los nombres de los metodos publicos y protegidos
Tiene un parametro opcional que si se setea a false no incluye en el Array los metodos de las superclases

# Conocer las variables de instancia de una clase.

El metodo es Object::instance_variables

Este retorna un Array con los nobmres de las variables de instancia

# Obtener la lista de ancestros (superclases) de una clase.

El metodo es Module::ancestors
