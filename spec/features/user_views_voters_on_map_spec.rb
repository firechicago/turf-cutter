require "rails_helper"

feature "user saves a list of voters", %(
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
    binding.pry

    click_link "View this list as a map"

    fill_in "List Name", with: "Sample list"
    click_button "Save this list"

    list.voters.each do |voter|
      expect(page).to have_content(voter.full_name)
    end
  end
end
