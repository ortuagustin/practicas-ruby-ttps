module Hora
  def self.en_palabras time
    hora = time.hour
    min = time.min
    unless min.between?(0, 55)
      return "Casi son las #{hora + 1}"
    end

    result = 'Son las ' 
    if min.between?(0, 10) then result << "#{hora} en punto"
    elsif min.between?(11, 20) then result << "#{hora} y cuarto" 
    elsif min.between?(21, 34) then result << "#{hora} y media" 
    elsif min.between?(35, 44) then result << "#{hora + 1} menos veinticinco" 
    elsif min.between?(45, 55) then result << "#{hora + 1} menos cuarto" 
    end
    result
  end
end
