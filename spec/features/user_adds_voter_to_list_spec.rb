require "rails_helper"

feature "user adds a voter to a list", %(
As a signed up user
I want to add a voter to a list
So that I can manually add people who weren't captured by the initial search
) do
  # Acceptance Criteria
  # [ ] A user can select a list from a voter's page and add that voter to
  #     that list
  # [ ] The user then receives a confirmation message and is taken to the
  #     list page

  scenario "adds voter to list" do
    sign_in_as(FactoryGirl.create(:user))
    list = FactoryGirl.create(:list)
    new_voter = FactoryGirl.create(:voter)

    visit voter_path(new_voter)

    select list.name, from: "List"
    click_button "Add to list"

    expect(page).to have_content("Voter added to Sample list")
    expect(page).to have_content(new_voter.full_name)
  end
  scenario "user not signed in" do
    visit voter_path(FactoryGirl.create(:voter))

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
