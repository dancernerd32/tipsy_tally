require "rails_helper"
feature "user adds a new drink", %Q{
  As a user,
  I want to be able to create a new drink,
  so that it can be reviewed and viewed in
  } do

  # Acceptance Critieria:
  # [X] When user creates a new drink,
  #     drink page displays the new drinks information
  # [X] Successfully adding a drink displays a
  #     message stating a new drink has been created
  # [X] Must specify a unique name, if name is not specified display error message
  # [X] Must specify either alcoholic or non alcoholic,
  #     if name is not specified display error message
  # []  If alcoholic, a list of alcohols should appear,
  #     allowing the user to pick several
  # [X] I can only input drink names that have at least 3 letters.
  # [X] I must input a description
  # [X] I must be signed in to be able to add a drink
  # [X] If drink is alcoholic, alcohol types must be specified
  # []  Can optionally provide a photo

  context "user is signed in" do
    before(:each) do
      @existing_user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: @existing_user.email
      fill_in "Password", with: @existing_user.password

      click_button "Log in"
    end

    scenario "signed in user inputs req'd fields correctly, non-alcoholic" do

      visit new_drink_path

      fill_in "Name", with: "Awesome New Beverage"
      choose "drink_alcoholic_false"
      fill_in "Description", with: "This is the best beverage evar!"

      click_on "Submit"

      expect(page).to have_content "Successfully created new drink"
      expect(page).to have_content "Awesome New Beverage"
      expect(page).to have_content "This is the best beverage evar!"
      expect(page).to have_content @existing_user.email
    end

    scenario "signed in user inputs mandatory fields correctly, alcoholic" do

      visit new_drink_path

      fill_in "Name", with: "Awesome New Beverage"
      fill_in "Description", with: "This is the best beverage evar!"

      check "Vodka"
      check "Gin"

      click_on "Submit"

      expect(page).to have_content "Successfully created new drink"
      expect(page).to have_content "Awesome New Beverage"
      expect(page).to have_content "This is the best beverage evar!"
      expect(page).to have_content "Vodka"
      expect(page).to have_content "Gin"
      expect(page).to have_content @existing_user.email
    end

    scenario "user does not enter mandatory fields" do

      visit new_drink_path

      click_on "Submit"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("(minimum is 3 characters)")
      expect(page).to have_content("Description can't be blank")
    end

    scenario "user enters a drink name that already exists" do
      existing_drink = FactoryGirl.create(:alcohol_drink)

      visit new_drink_path

      fill_in "Name", with: existing_drink.name
      fill_in "Description", with: existing_drink.description

      click_on "Submit"

      expect(page).to have_content "Name has already been taken"
    end

    scenario "user specifies alcoholic, but does not select any liquors" do

      visit new_drink_path

      fill_in "Name", with: "Awesome New Beverage"
      fill_in "Description", with: "This is the best beverage evar!"

      click_on "Submit"

      expect(page).to have_content("Drink Liquors can't be blank if alcoholic")
    end
  end

  context "visitor is not signed in" do

    scenario "visitor attempts to create a new drink" do

      visit root_path

      click_on "New Drink"

      expect(page).to have_content("sign up before continuing")
    end
  end

end
