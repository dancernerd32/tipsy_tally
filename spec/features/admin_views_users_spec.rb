require "rails_helper"

feature "Admin views a list of users", %{
  As an admin,
  I want to view a list of users
  So I know who is on my site
  } do
  #
  # Acceptance Criteria:
  # [X] I must be logged in, and an admin to view the list of users
  # [X] Every user is listed alphabetically by username
  # [X] When I click on a username, I am taken to their user profile
  # [X] I can get to this page by clicking on the option in the admin homepage

  context "Admin is signed in" do
    before(:each) do
    @admin1 = FactoryGirl.create(:user, role: "Admin")
      visit root_path

      click_on "Sign In"

      fill_in "Login", with: @admin1.email
      fill_in "Password", with: @admin1.password
      click_on "Log in"
    end

    scenario "Admin follows paths to view a user's profile" do
      user1 = FactoryGirl.create(:user, username: "Cori")
      user2 = FactoryGirl.create(:user, username: "Mike")
      user3 = FactoryGirl.create(:user, username: "Lauren")

      visit root_path

      click_on "Admin Panel"

      click_on "View Users"

      expect(find("ul#users li:nth-child(1)")).to have_content "Cori"
      expect(find("ul#users li:nth-child(4)")).to have_content "username1"

      click_on user1.username

      expect(page).to have_content user1.username
      expect(page).to have_content user1.email
    end
  end

  context "Visitor is not signed in" do
    scenario "Visitor tries to view admin pages" do
      visit root_path

      expect(page).not_to have_content "Admin Panel"

      visit admin_path

      expect(page).to have_content "You need to sign in or sign up before continuing"

      visit admin_users_path

      expect(page).to have_content "You need to sign in or sign up before continuing"
    end
  end

  context "User is not an admin" do

    before(:each) do
      user = FactoryGirl.create(:user)
      visit root_path

      click_on "Sign In"

      fill_in "Login", with: user.email
      fill_in "Password", with: user.password
      click_on "Log in"
    end

    scenario "User tries to view admin pages" do
      visit root_path

      expect(page).not_to have_content "Admin Panel"

      visit admin_path

      expect(page).to have_content "You are not authorized to view that page"

      visit admin_users_path

      expect(page).to have_content "You are not authorized to view that page"
    end
  end
end
