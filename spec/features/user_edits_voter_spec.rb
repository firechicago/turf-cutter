require "rails_helper"

feature "user edits a voter", %(
As a signed up user
I want to edit a voter
So that I can update that voter with new contact information
) do
  # Acceptance Criteria
  # [ ] A user enters the voter's information
  # [ ] If the information is valid, the voter's information is updated in the
  #     database, and the user is taken to the voter's view page
  # [ ] If the information is invalid, the user receives an error message, and
  #     is returned to the edit voter page
  scenario "provides valid voter information" do
    sign_in_as(FactoryGirl.create(:user))
    voter = FactoryGirl.create(:voter)
    visit edit_voter_path(voter)

    fill_in "First name", with: "John Q."
    fill_in "Last name", with: "Public"
    fill_in "Address1", with: "123 Main St."
    fill_in "Address2", with: "Apartment 1"
    fill_in "City", with: "Anytown"
    fill_in "State", with: "MA"
    fill_in "Zip", with: "01234"

    click_button "Update Voter"

    expect(page).to have_content("Voter Updated")
    expect(page).to have_content("John Q. Public")
  end

  scenario "specify invalid information" do
    sign_in_as(FactoryGirl.create(:user))
    voter = FactoryGirl.create(:voter)
    visit edit_voter_path(voter)

    fill_in "First name", with: ""
    click_button "Update Voter"

    expect(page).to have_content("Error")
    expect(page).to have_content("First name can't be blank")
  end
  scenario "user not signed in" do
    visit edit_voter_path(FactoryGirl.create(:voter))

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
