require "rails_helper"

feature "Delete user", %{
  As an admin,
  I want to be able to delete a user,
  So that I can get rid of trolls
} do
  # Acceptance Criteria:
  #
  # [] I must be signed in as an admin to remove a user
  # [] When I delete a user, a mailer must notify the user their account has
  #    been removed and why
  # [] I must have a way of deleting a user

  context "Admin is signed in" do
      before(:each) do
        @admin1 = FactoryGirl.create(:user, role: "Admin", username: "Xavier")
        visit root_path

        click_on "Sign In"

        fill_in "Login", with: @admin1.email
        fill_in "Password", with: @admin1.password
        click_on "Log in"
      end
    scenario "Admin successfully deletes a user" do
      user = FactoryGirl.create(:user, username: "Alex")

      visit admin_users_path

      first(".button_to").click_button "Delete User"

      expect(page).to have_content "Successfully deleted #{user.username}"
      expect("#users").not_to have_content user.username
    end
  end
end
