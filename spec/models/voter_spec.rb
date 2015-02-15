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

RSpec.describe Voter, ".full_address" do
  it "returns full address, including city, state and zip" do
    voter = FactoryGirl.create(:voter)
    expect(voter.full_address).to eq(
    "#{voter.address1} #{voter.address2}, #{voter.city}, #{voter.state} #{voter.zip}"
    )
  end
end

RSpec.describe Voter, ".valid_coords?" do
  it "checks if the voter has floats for lat and long" do
    voter = FactoryGirl.create(:voter)
    expect(voter.valid_coords?).to eq true
    voter.latitude = nil
    voter.longitude = nil
    expect(voter.valid_coords?).to eq false
  end
end
