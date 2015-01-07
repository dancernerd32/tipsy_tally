require "rails_helper"

feature "Admin views drinks", %{
  As an admin,
  I want to be view current drinks,
  So that I can moderate submissions
  } do

  # Acceptance Criteria:
  #
  # [X] I must be signed in as an admin to view drinks in the admin panel

  context "Admin is signed in" do
    before(:each) do
      @admin1 = FactoryGirl.create(:user, role: "admin")
      visit root_path

      click_on "Sign In"

      fill_in "Login", with: @admin1.email
      fill_in "Password", with: @admin1.password
      click_on "Log in"
    end

    scenario "Admin follows paths to view a drinks details" do
      drink1 = FactoryGirl.create(:drink)
      drink2 = FactoryGirl.create(:drink)

      visit root_path

      click_on "Admin Panel"

      click_on "View Drinks"

      expect(page).to have_content(drink1.name)
      expect(page).to have_content(drink2.name)
    end
  end

  context "Visitor is not signed in" do
    scenario "Visitor tries to view admin drinks pages" do
      visit admin_drinks_path

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

    scenario "User tries to view admin drinks pages" do

      visit admin_drinks_path

      expect(page).to have_content "You are not authorized to view that page"
    end
  end
end
