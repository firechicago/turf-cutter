require "rails_helper"

feature "user views a list on a map", %(
As a signed up user
I want to view a list of voters on a map
So that I can see where they are located
) do
  # Acceptance Criteria
  # [ ] A user can view a list of voters displayed as markers on a map

  scenario "searches and saves a page" do
    sign_in_as(FactoryGirl.create(:user))
    list = FactoryGirl.create(:list)
    visit list_path(list)

    click_link "Cut turf from this list"

    expect(page).to have_content("Save these turfs")
  end

  scenario "user not signed in" do
    list = FactoryGirl.create(:list)
    visit list_path(list)

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
