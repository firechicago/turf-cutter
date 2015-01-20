require "rails_helper"

feature "user logs a contact", %(
As a signed up user
I want to log a contact with a voter
So that I can keep track of our voter outreach
) do
  # Acceptance Criteria
  # [ ] A user enters the result of the contact, the support score (1-5)
  #     and any relevant notes about the contact
  # [ ] If the information is valid, the user gets a confirmation message and
  #     the contact is displayed on the voters page
  # [ ] If the information is invalid, the user receives an error message

  scenario "provides valid contact input" do
    sign_in_as(FactoryGirl.create(:user))
    voter = FactoryGirl.create(:voter)
    contact = Contact.new
    contact.note = "They're Undecided"
    visit voter_path(voter)
    click_link "Log new contact"

    select "Contacted", from: "Outcome"
    select "3 - Undecided", from: "Support"
    fill_in "Note", with: contact.note

    click_button "Log Contact"

    expect(page).to have_content("Contact Logged")
    expect(page).to have_content(contact.note)
  end

  scenario "specify invalid information" do
    sign_in_as(FactoryGirl.create(:user))
    voter = FactoryGirl.create(:voter)
    visit voter_path(voter)
    click_link "Log new contact"

    click_button "Log Contact"

    expect(page).to have_content("Error")
    expect(page).to have_content("Result can't be blank")
  end

  scenario "user not signed in" do
    visit new_contact_voter_path(FactoryGirl.create(:voter))

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
