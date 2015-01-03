class Voter < ActiveRecord::Base

  validates :first_name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
