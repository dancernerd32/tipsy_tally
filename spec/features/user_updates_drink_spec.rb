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
    # [X] I must include a name
    # [X] I must include a description
    # [X] I cannot change whether or not a drink is alcoholic
    # [X] If a drink is non-alcoholic, there will be no option
    #    to add a liquor
    # [x] If a drink is alcoholic, you may add or remove
    #    liquors
    # [X] If a drink is alcoholic, at least one liquor must be
    #    specified
    # [x] When a user updates a drink, the drink's show page
    #    displays the drink's new information
    # [X] Successfully updating a drink takes you back to the drink page and
    #    displays a message stating the drink has been updated
    # [X] If I don't specify the required information, I am
    #    presented with an error message

  context "authenticated user" do
    before(:each) do
      @user1 = FactoryGirl.create(:user)

      visit root_path


      click_on "Sign In"


      fill_in "Login", with: @user1.email
      fill_in "Password", with: @user1.password
      click_on "Log in"
    end

    scenario "user views edit page"

    scenario "user updates alcoholic drink with valid information" do
      drink = FactoryGirl.create(:alcohol_drink, user: @user1)

      visit drink_path(drink)

      click_on "Edit Drink"

      fill_in "Name", with: "New Name"
      fill_in "Description", with: "New Description"

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

    scenario "user updates non-alcoholic drink with valid information" do
      drink = FactoryGirl.create(:non_alcohol_drink, user: @user1)

      visit drink_path(drink)
      click_on "Edit Drink"

      fill_in "Name", with: "New Name"
      fill_in "Description", with: "New Description"

      expect(page).not_to have_content "Tequila"
      click_on "Submit"

      expect(page).to have_content "New Name"
      expect(page).to have_content "New Description"
      expect(page).to have_content "Successfully updated drink"
    end

    scenario "user submits invalid information for alcoholic drink" do
      drink = FactoryGirl.create(:alcohol_drink, user: @user1)

      visit edit_drink_path(drink)

      fill_in "Name", with: ""
      fill_in "Description", with: ""
      uncheck "Rum"
      uncheck "Vodka"

      click_on "Submit"

      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Description can't be blank"
      expect(page).to have_content "can't be blank if alcoholic"
    end

    scenario "user submits invalid information for non-alcoholic drink" do
      drink = FactoryGirl.create(:non_alcohol_drink, user: @user1)

      visit edit_drink_path(drink)

      fill_in "Name", with: ""
      fill_in "Description", with: ""

      click_on "Submit"

      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Description can't be blank"
      expect(page).not_to have_content "can't be blank if alcoholic"
    end

    scenario "user tries to edit another users drink" do
      user2 = FactoryGirl.create(:user)
      drink = FactoryGirl.create(:alcohol_drink, user: user2)

      visit edit_drink_path(drink)

      expect(page).to have_content "You cannot edit someone else's drink"
    end

  end
  context "visitor is not signed in" do

    scenario "visitor tries to update drink" do
      drink = FactoryGirl.create(:alcohol_drink)

      visit edit_drink_path(drink)

      expect(page).to have_content "You must be signed in to do that"
    end
  end
end
