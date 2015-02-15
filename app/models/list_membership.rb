class ListMembership < ActiveRecord::Base
  belongs_to :voter
  belongs_to :list

  validates :voter_id, presence: true
  validates :list_id, presence: true
end
