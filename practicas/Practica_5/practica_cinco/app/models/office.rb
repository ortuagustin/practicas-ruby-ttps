class Office < ApplicationRecord
  has_many :employees # necesario para que funcione el scope que usa employees_count y el counter_cache?
  # validates_associated: employees implicito en has_many, ver punto 4.3.2.12 :validate en
  # http://guides.rubyonrails.org/association_basics.html#has-many-association-reference
  scope :available, -> { where(available: true) }
  scope :empty, -> { available.where(employees_count: 0) }
  validates :name, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true, length: { maximum: 30 }
  validates :available, inclusion: { in: [true, false] }
  validates :available, exclusion: { in: [nil] }

  def to_s
    "Office named: #{name}, at address: #{address}, with phone: #{phone_number}"
  end
end
