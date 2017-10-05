class Time
  def self.midnight
    now = self.now
    self.new(now.year, now.month, now.day, 23, 59, 59)
  end
end

def cuanto_falta? time = Time.midnight
  (time - Time.now) / 60
end