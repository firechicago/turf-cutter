class List < ActiveRecord::Base
  has_many :voters, through: :list_memberships
  has_many :list_memberships
  validates :name, presence: true
end
