class Employee < ApplicationRecord
  belongs_to :office, counter_cache: true, optional: true
  scope :vacant, -> { where(office_id: nil) }
  scope :occupied, -> { where.not(office_id: nil) }
  scope :occupied_negating_vacant, -> { where.not.vacant } # existe alguna forma de reusar el scope :vacant pero negandolo?
  scope :occupied_association, -> { joins(:office) } # necesito el belongs_to en Employee y el has_many en Office para que me funcione el counter_cache?
  validates :name, presence: true, length: { maximum: 150 }
  validates :integer, presence: true, uniqueness: true # igual es mejor tener el indice unique en la DB
end
