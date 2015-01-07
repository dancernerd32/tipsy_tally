require "rails_helper"

feature "Delete user", %{
  As an admin,
  I want to be able to delete a drink,
  So that I can get rid of unrelated submissions
  } do

  # Acceptance Criteria:
  #
  # [X] I must be signed in as an admin to remove a user
  # [X] I must have a way of deleting a user

  context "Admin is signed in" do
    before(:each) do
      @admin1 = FactoryGirl.create(:user, role: "Admin")
      visit root_path

      click_on "Sign In"

      fill_in "Login", with: @admin1.email
      fill_in "Password", with: @admin1.password
      click_on "Log in"
    end

    scenario "Admin successfully deletes a drink" do
      drink1 = FactoryGirl.create(:drink)
      drink2 = FactoryGirl.create(:drink, name: "drink to be destroyed")

      visit admin_drinks_path

      click_button ("Destroy " + drink2.name)

      expect(page).to have_content "Successfully deleted #{drink2.name}"
      expect("#drinks").not_to have_content drink2.name
    end
  end
end
