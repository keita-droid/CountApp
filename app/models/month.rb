class Month < ApplicationRecord
  has_many :business_days
  
  # validation
  validates :month, presence: true, uniqueness: true
end
