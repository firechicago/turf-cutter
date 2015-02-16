require 'rails_helper'

RSpec.describe List, :type => :model do
  it { should validate_presence_of(:name) }

  it { should have_many(:list_memberships) }
  it { should have_many(:voters) }
end
