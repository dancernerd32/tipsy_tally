require "rails_helper"

feature "user edits account", %{

  As a registered user
  I want to be able to edit my account
  So my information is up to date
  } do
    # Acceptance Criteria
    # *I must be logged in
    # *I can only edit my own account
    # *I can change or upload an optional avatar
    # *I can change my password
    # *I can change my email
    # *I cannot change my username

    scenario "authenticated user changes email, password, & avatar" do

      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Login", with: user.username
      fill_in "Password", with: user.password

      click_button "Log in"

      visit edit_user_registration_path

      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "Testing12345"
      fill_in "Password confirmation", with: "Testing12345"
      fill_in "Current password", with: user.password

      click_button "Update"

      expect(page).to have_content("Your account has been updated successfully")

    end

    scenario "authenticated user attempts to update with invalid information" do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Login", with: user.username
      fill_in "Password", with: user.password

      click_button "Log in"

      visit edit_user_registration_path

      fill_in "Email", with: ""
      fill_in "Password", with: "Testing12345"
      fill_in "Password confirmation", with: "Testing12345"
      fill_in "Current password", with: user.password

      click_button "Update"

      expect(page).to have_content("Email can't be blank")
    end

    scenario "unauthenticated user attempts to change email" do

      visit edit_user_registration_path

      expect(page).to have_content("You need to sign in or sign up before
      continuing.")

    end

  end
