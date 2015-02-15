require 'rails_helper'

RSpec.describe Contact, :type => :model do
  it { should validate_presence_of(:outcome) }
  it { should validate_presence_of(:voter_id) }
  it { should validate_presence_of(:user_id) }

  it { should belong_to(:voter) }
  it { should belong_to(:user) }
end
