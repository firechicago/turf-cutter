require "rails_helper"

feature "user saves a list of voters", %(
As a signed up user
I want to save a list of voters
So that I can keep track of voters
) do
  # Acceptance Criteria
  # [ ] A user can save a search as a list of voters
  # [ ] The user must supply a name for the list
  # [ ] The user is then taken to a page showing those voters

  scenario "searches and saves a page" do
    sign_in_as(FactoryGirl.create(:user))
    @voters = FactoryGirl.create_list(:voter, 51)
    visit new_search_path

    fill_in "First name", with: "John"

    click_button "Search"

    fill_in "List Name", with: "Sample list"
    click_button "Save this list"

    expect(page).to have_content("List saved")

    @voters[0..24].each do |voter|
      expect(page).to have_content(voter.first_name)
    end

    click_link 'Next'

    @voters[25..49].each do |voter|
      expect(page).to have_content(voter.first_name)
    end

    click_link 'Next'

    expect(page).to have_content(@voters[-1].first_name)
  end
  
  scenario "does not enter a list name" do
    sign_in_as(FactoryGirl.create(:user))
    @voters = FactoryGirl.create_list(:voter, 10)
    visit new_search_path

    fill_in "First name", with: "John"

    click_button "Search"

    click_button "Save this list"

    expect(page).to have_content("Save failed")

  end
  scenario "user not signed in" do
    visit new_search_path

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
