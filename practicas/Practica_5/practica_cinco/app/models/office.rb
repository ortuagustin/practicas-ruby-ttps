class Office < ApplicationRecord
  def to_s
    "Office named: #{name}, at address: #{address}, with phone: #{phone_number}"
  end
end
