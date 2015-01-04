class Voter < ActiveRecord::Base
  def full_name
    "#{first_name} #{last_name}"
  end

  validates :first_name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
