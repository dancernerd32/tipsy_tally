require "rails_helper"

feature "User deletes a drink", %{
  As an authenticated user,
  I want to delete my drink,
  So that no one can review it
  } do

  # Acceptance Criteria:
  # [] I must be logged in
  # [] I can only delete my own drinks
  # [] When I delete a drink, I am redirected to the drinks index page and given
  #    a success message
  # [] If I am not logged in, I cannot see the option to delete a drink
  # [] If the drink is not mine, I cannot see the option to delete the drink

  context "User is logged in" do
    before(:each) do
      @user1 = FactoryGirl.create(:user)

      visit root_path

      click_on "Sign In"

      fill_in "Login", with: @user1.email
      fill_in "Password", with: @user1.password
      click_on "Log in"
    end


    scenario "User deletes their own drink" do
      drink = FactoryGirl.create(:alcohol_drink, user: @user1)

      visit drink_path(drink)
      click_on "Delete Drink"

      expect(page).to have_content "Successfully deleted drink"
      expect(page).not_to have_content drink.name
    end
  end
end
