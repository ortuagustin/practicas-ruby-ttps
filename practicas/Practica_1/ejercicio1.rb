array = [1, 2, 3] # => [1, 2, 3]
array = Array.new # => []
array[0] = 1 #=> [1]
array[1] = 2 #=> [1, 2]
array = Array.new 3 # => [nil, nil, nil]

hash = { key: 'value' } # => {:key=>"value"}
hash = { nombre: 'Agustin', apellido: 'Ortu', legajo: '11329/6' } #=> {:nombre=>"Agustin", :apellido=>"Ortu", :legajo=>"11329/6"}
hash[:nombre] # => "Agustin"
hash[:apellido] # => "Ortu"
hash[:legajo] # => "11329/6"

hash = Hash.new # => {}
hash[:mail] # => nil
hash[123] # => nil

hash = Hash.new 'valor por defecto' # => {}
hash[:mail] # => "valor por defecto"
hash[123] # => "valor por defecto"

string = 'esto es un string' # => "esto es un string"
string = "esto tambien" # => "esto tambien"
string = String.new # => ""
string = String.new 'usando constructor' # => "usando constructor"
string = String.new "usando constructor" # => "usando constructor"

simbolo = :Hola # => :Hola
simbolo.object_id == :Hola.object_id # => true
simbolo = 'hola'.to_sym # => :hola
simbolo.object_id == :hola.object_id # => true