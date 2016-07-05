class Contact < ApplicationRecord
  belongs_to :state
  
  validates :name, presence: true
  validates :age, numericality: {
  	only_integer: true,
  	greater_than_or_equal_to: 0 #allow newborns
  }
  validates :role, presence: true
  validates :email, 
  	presence: true,
  	uniqueness: true,
  	format: {with: /@/},
  	length: {minimum: 3}
  validates_associated :state
end
