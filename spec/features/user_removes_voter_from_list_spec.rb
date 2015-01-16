require "rails_helper"

feature "user removes a voter from a list", %(
As a signed up user
I want to remove a voter from a list
So that I can manually remove people who shouldn"t be contacted
) do
  # Acceptance Criteria
  # [ ] A user can delete a voter from a lists show page
  # [ ] The user then receives a confirmation message and is returned to the
  #     list page

  scenario "removes voter from list" do
    sign_in_as(FactoryGirl.create(:user))
    list = FactoryGirl.create(:list)
    visit list_path(list)

    voter = list.voters[0]
    list_count = list.voters.length

    click_link "Remove #{voter.first_name} from this list"

    expect(page).to have_content("Voter removed")
    expect(page).to_not have_content(voter.full_name)
    expect(List.find(list.id).voters.length).to eq(list_count - 1)
  end

  scenario "user not signed in" do
    list = FactoryGirl.create(:list)
    visit list_path(list)

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
