require 'rails_helper'

RSpec.describe ListMembership, :type => :model do
  it { should validate_presence_of(:voter_id) }
  it { should validate_presence_of(:list_id) }

  it { should belong_to(:voter) }
  it { should belong_to(:list) }
end
