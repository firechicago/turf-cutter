require 'rails_helper'
require 'spec_helper'

describe Voter, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:address1) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }

  it { should have_many(:list_memberships) }
  it { should have_many(:contacts) }
end

RSpec.describe Voter, ".full_name" do
  it "returns full name" do
    voter = FactoryGirl.create(:voter)
    expect(voter.full_name).to eq voter.first_name + " " + voter.last_name
  end
end
