require "rails_helper"

feature "user uploads a csv of voters", %(
As a signed up user
I want to add voters to the database by uploading a csv
So that I can add large numbers of voters at once
) do
  # Acceptance Criteria
  # [ ] A user can upload a csv with voter information to create new voter records
  # [ ] If the upload is not successful, the user is given an error message

  before(:each) do
    sign_in_as(FactoryGirl.create(:user))
  end

  scenario "uploads a valid csv", focus: true do
    visit new_voter_path

    attach_file "voters_csv", "spec/support/test_csv.csv"
    click_button "Upload Voters"

    expect(page).to have_content("Voters successfully uploaded")
    expect(page).to have_content("John Doe")
  end

  scenario "uploads an invalid csv", focus: true do
    visit new_voter_path

    attach_file "voters_csv", "spec/support/bad_csv.csv"
    click_button "Upload Voters"

    expect(page).to have_content("There were errors reading lines")
  end
end
