require 'rails_helper'

feature 'user removes a voter from a list', %(
As a signed up user
I want to remove a voter from a list
So that I can manually remove people who shouldn't be contacted
) do
  # Acceptance Criteria
  # [ ] A user can delete a voter from a lists show page
  # [ ] The user then receives a confirmation message and is returned to the
  #     list page

  scenario 'removes voter from list' do
    sign_in_as(FactoryGirl.create(:user))
    FactoryGirl.create_list(:voter, 10)
    visit new_search_path

    fill_in "First name", with: "John"

    click_button "Search"

    fill_in "List Name", with: "Sample list"
    click_button "Save this list"

    list = List.first
    voter = list.voters[0]
    list_count = list.voters.length

    click_link "Remove #{voter.full_name} from this list"

    expect(page).to have_content("Voter removed")
    expect(page).to_not have_content(voter.full_name)
    expect(List.find(list.id).voters.length).to eq(list_count - 1)
  end
end
