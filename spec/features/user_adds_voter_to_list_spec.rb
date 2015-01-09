require 'rails_helper'

feature 'user adds a voter to a list', %(
As a signed up user
I want to add a voter to a list
So that I can manually add people who weren't captured by the initial search
) do
  # Acceptance Criteria
  # [ ] A user can select a list from a voter's page and add that voter to
  #     that list
  # [ ] The user then receives a confirmation message and is taken to the
  #     list page

  scenario 'adds voter to list' do
    sign_in_as(FactoryGirl.create(:user))
    @voters = FactoryGirl.create_list(:voter, 10)
    visit new_search_path

    fill_in "First name", with: "John"

    click_button "Search"

    fill_in "List Name", with: "Sample list"
    click_button "Save this list"

    new_voter = FactoryGirl.create(:voter)
    visit voter_path(new_voter)

    select "Sample list", from: "List"
    click_button "Add to list"

    expect(page).to have_content("Voter added to Sample list")
    expect(page).to have_content(new_voter.full_name)
  end
end
