require 'rails_helper'

feature 'user creates a voter', %(
  As a signed up user
  I want to manually create a voter
  So that I can track my campaigns contacts with that voter
  ) do
  # Acceptance Criteria
  # [ ] A user enters the voter's information
  # [ ] If the information is valid, the voter is added to the database, and
  #     the user is taken to the voter's view page
  # [ ] If the information is invalid, the user receives an error message, and
  #     is returned to the create voter page
    scenario 'create a valid voter' do
      sign_in_as(FactoryGirl.create(:user))

      visit new_voter_path

      fill_in 'First name', with: "John Q."
      fill_in 'Last name', with: "Public"
      fill_in "Address1", with: "123 Main St."
      fill_in "Address2", with: "Apartment 1"
      fill_in "City", with: "Anytown"
      fill_in "State", with: "MA"
      fill_in "Zip", with: "01234"

      click_button 'Submit'

      expect(page).to have_content('Voter Created')
      expect(page).to have_content("John Q. Public")
    end

    scenario 'specify invalid information' do
      visit new_voter_path

      click_button 'Submit'
      expect(page).to have_content('Error')
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Address1 can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip can't be blank")
    end
  end
