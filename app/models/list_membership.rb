class ListMembership < ActiveRecord::Base
  belongs_to :voter
  belongs_to :list
end
