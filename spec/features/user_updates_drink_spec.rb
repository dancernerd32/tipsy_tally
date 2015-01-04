require 'rails_helper'

feature 'user registers', %{
  As an authenticated user
  I want to update an item's information
  So that I can correct errors or provide new information
  } do

    # Acceptance Criteria:
    # [] I must be logged in
    # [] I must be the creator of the drink I want to update
    # [x] I can change the name of a drink
    # [x] I can change the description
    # [] I must include a name
    # [] I must include a description
    # [] I cannot change whether or not a drink is alcoholic
    # [] If a drink is non-alcoholic, there will be no option
    #    to add a liquor
    # [x] If a drink is alcoholic, you may add or remove
    #    liquors
    # [] If a drink is alcoholic, at least one liquor must be
    #    specified
    # [x] When a user updates a drink, the drink's show page
    #    displays the drink's new information
    # [] Successfully updating a drink takes you back to the drink page and
    #    displays a message stating the drink has been updated
    # [] If I don't specify the required information, I am
    #    presented with an error message

  context 'authenticated user' do
    before(:each) do
      @user1 = FactoryGirl.create(:user)

      visit root_path


      click_on "Sign In"


      fill_in "Email", with: @user1.email
      fill_in "Password", with: @user1.password
      click_on "Log in"
    end

    scenario 'user views edit page'

    scenario 'user updates alcoholic drink with valid information' do
      drink = FactoryGirl.create(:alcohol_drink, user: @user1)

      visit drink_path(drink)

      click_on 'Edit Drink'

      fill_in 'Name', with: "New Name"
      fill_in 'Description', with: "New Description"

      check "Gin"
      check "Liqueur(s)"
      check "Other"
      uncheck "Rum"
      check "Tequila"
      check "Scotch"
      check "Cognac"
      check "Brandy"
      check "Whiskey"
      uncheck "Vodka"

      click_on "Submit"

      expect(page).to have_content "New Name"
      expect(page).to have_content "New Description"
      expect(page).to have_content "Gin"
      expect(page).not_to have_content "Rum"
      expect(page).to have_content "Liqueur(s)"
      expect(page).to have_content "Other"
      expect(page).to have_content "Tequila"
      expect(page).to have_content "Scotch"
      expect(page).to have_content "Cognac"
      expect(page).to have_content "Brandy"
      expect(page).to have_content "Whiskey"
      expect(page).not_to have_content "Vodka"
      expect(page).to have_content "Successfully updated drink"
    end

    scenario 'user updates non-alcoholic drink with valid information'
    scenario 'user submits invalid information'
    scenario 'user tries to edit another users drink'

  end
  context 'user is not signed in' do
    scenario 'visitor tries to update drink'
  end
end
