require "rails_helper"

feature "User deletes a drink", %{
  As an authenticated user,
  I want to delete my drink,
  So that no one can review it
  } do

  # Acceptance Criteria:
  # [X] I must be logged in
  # [X] I can only delete my own drinks
  # [X] When I delete a drink, I am redirected to the drinks index page and
  #     given a success message
  # [X] If I am not logged in, I cannot see the option to delete a drink
  # [X] If the drink is not mine, I cannot see the option to delete the drink

  context "User is logged in" do
    before(:each) do
      @user1 = FactoryGirl.create(:user)

      visit root_path

      click_on "Sign In"

      fill_in "Login", with: @user1.email
      fill_in "Password", with: @user1.password
      click_on "Log in"
    end

    scenario "User deletes their own alcoholic drink" do
      drink = FactoryGirl.create(:alcohol_drink, user: @user1)

      visit drink_path(drink)
      click_on "Delete Drink"

      expect(page).to have_content "Successfully deleted drink"
      expect(page).not_to have_content drink.name
    end

    scenario "User looks for delete option for someone else's
    alchoholic drink" do
      user2 = FactoryGirl.create(:user)
      drink = FactoryGirl.create(:alcohol_drink, user: user2)

      visit drink_path(drink)

      expect(page).not_to have_content "Delete Drink"
    end

    scenario "User deletes their own non-alcoholic drink" do
      drink = FactoryGirl.create(:drink, user: @user1)

      visit drink_path(drink)
      click_on "Delete Drink"

      expect(page).to have_content "Successfully deleted drink"
      expect(page).not_to have_content drink.name
    end

    scenario "User looks for delete option for someone else's
    non-alchoholic drink" do
      user2 = FactoryGirl.create(:user)
      drink = FactoryGirl.create(:drink, user: user2)

      visit drink_path(drink)

      expect(page).not_to have_content "Delete Drink"
    end
  end

  context "User is not logged in" do
    scenario "User looks for delete option on a non-alcoholic drink" do
      drink = FactoryGirl.create(:drink)

      visit drink_path(drink)

      expect(page).not_to have_content "Delete Drink"
    end

    scenario "User looks for delete option on a alcoholic drink" do
      drink = FactoryGirl.create(:alcohol_drink)

      visit drink_path(drink)

      expect(page).not_to have_content "Delete Drink"
    end
  end
end
