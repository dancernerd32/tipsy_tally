require "rails_helper"

feature "View profile page" do
  scenario "User views their own profile" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in "Login", with: user.username
    fill_in "Password", with: user.password

    click_button "Log in"

    visit user_path(user)

    expect(page).to have_content user.email

    click_on "Edit profile"

    expect(page).to have_content "password"
  end
end
