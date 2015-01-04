require 'rails_helper'

feature 'user deletes a voter', %(
As a signed up user
I want to delete a voter
So that I can remove ineligible or erroneous voters
) do
  # Acceptance Criteria
  # [ ] From a voter's edit page, a user can click on a delete link
  # [ ] If the user clicks this link and then confirms, the voter will be
  #     deleted, and the user will be notified

  scenario 'user deletes a voter' do
    sign_in_as(FactoryGirl.create(:user))
    voter = FactoryGirl.create(:voter)
    visit edit_voter_path(voter)

    click_on 'Delete this voter'

    expect(page).to have_content('Voter deleted')
    expect(Voter.find_by(
      first_name: voter.first_name,
      last_name: voter.last_name,
      address1: voter.address1
    )).to eq(nil)
  end
end
