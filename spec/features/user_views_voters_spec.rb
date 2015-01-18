require "rails_helper"

feature "user views all voters", %(
As a signed up user
I want view all voters
So that I can find one that I need
) do
  # Acceptance Criteria
  # [ ] A user can view a list of all voters
  # [ ] The list is paginated
  # [ ] Only a logged in user can do this

  scenario "logged in" do
    sign_in_as(FactoryGirl.create(:user))
    @voters = FactoryGirl.create_list(:voter, 51)
    visit voters_path

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

  scenario "not logged in" do
    visit voters_path

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
