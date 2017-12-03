class Office < ApplicationRecord
  has_many :employees # necesario para que funcione el scope que usa employees_count y el counter_cache?
  scope :available -> { where(available) }
  scope :empty -> { :available.where(employees_count = 0) }

  def to_s
    "Office named: #{name}, at address: #{address}, with phone: #{phone_number}"
  end
end
