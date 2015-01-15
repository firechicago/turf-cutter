require "rails_helper"

feature "user searches voters", %(
As a signed up user
I want to search on all available attributes
So that I can find voters to contact
) do
  # Acceptance Criteria
  # [ ] A user enters search criteria into a search page
  # [ ] The user is then taken to a page that shows all of the voters that meet
  #     their criteria
  # [ ] If no voters meet the criteria, the user receives a message to that
  #     effect
  before(:each) do
    sign_in_as(FactoryGirl.create(:user))
    @voters = FactoryGirl.create_list(:voter, 51)
  end

  scenario "finds a single record" do
    visit new_search_path

    fill_in "First name", with: @voters[0].first_name

    click_button "Search"

    expect(page).to have_content("1 voter found")
    expect(page).to have_content(@voters[0].first_name)
  end

  scenario "finds multiple records" do
    visit new_search_path

    fill_in "First name", with: "John"

    click_button "Search"

    expect(page).to have_content("51 voters found")
    @voters[0..24].each do |voter|
      expect(page).to have_content(voter.first_name)
    end

    click_link "Next"

    @voters[25..49].each do |voter|
      expect(page).to have_content(voter.first_name)
    end

    click_link "Next"

    expect(page).to have_content(@voters[-1].first_name)
  end

  scenario "finds no records" do
    visit new_search_path

    fill_in "First name", with: "Zaphod Beeblebrox"

    click_button "Search"

    expect(page).to have_content("No voters found")
    expect(page).to_not have_content(@voters[0].first_name)
  end

  scenario "user not signed in" do
    click_link("Sign Out")
    visit new_search_path

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
