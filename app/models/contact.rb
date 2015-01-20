class Contact < ActiveRecord::Base
  def self.poss_outcomes
    [
      "Contacted",
      "Not Home",
      "Moved",
      "Deceased",
      "Inaccessible",
      "Left Message"
    ]
  end

  belongs_to :voter
  belongs_to :user
  validates :outcome, presence: :true, inclusion: { in: Contact.poss_outcomes }
  validates :voter_id, presence: :true
  validates :user_id, presence: :true
end
