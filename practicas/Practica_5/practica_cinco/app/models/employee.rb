class Employee < ApplicationRecord
  belongs_to :office, counter_cache: true
  scope :vacant -> { where(office_id: nil) }
  scope :occupied -> { where.not(office_id: nil) }
  scope :occupied_association -> { joins(:office) } # necesito el belongs_to en Employee y el has_many en Office para que me funcione el counter_cache?
end
