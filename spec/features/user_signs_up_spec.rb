require "rails_helper"

feature "user registers", %{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # * I must specify a valid email address, username,
  #   password, and password confirmation
  # * Email, username, and password must be unique
  # * I can optionally provide an avatar
  # * If I don't specify the required information, I am presented with
  #   an error message

  scenario "provide valid registration information - no avatar" do
    visit new_user_registration_path

    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Username", with: "John"

    click_button "Sign up"

    expect(find("img")["src"]).to have_content "default.jpg"
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario "provide valid registration information - with avatar" do

    visit new_user_registration_path

    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Username", with: "John"
    attach_file("user[avatar]", Rails.root + "spec/fixtures/default_av.jpg")
    click_button "Sign up"

    # within[id]
    expect(find("img")["src"]).to have_content "default_av.jpg"
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")

  end

  scenario "provide invalid registration information - field left empty" do
    visit new_user_registration_path

    click_button "Sign up"
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "provide invalid registration information - email not unique" do

    user = FactoryGirl.create(:user)

    visit new_user_registration_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Username", with: "John"

    click_button "Sign up"

    expect(page).to have_content("Email has already been taken")

  end

  scenario "provide invalid registration information - username not unique" do

    user = FactoryGirl.create(:user)

    visit new_user_registration_path

    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Username", with: user.username

    click_button "Sign up"

    expect(page).to have_content("Username has already been taken")

  end

  scenario "provide invalid registration information - password does not match
  confirmation" do

    visit new_user_registration_path

    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "1password"
    fill_in "Username", with: "John"

    click_button "Sign up"
    expect(page).to have_content("Password confirmation doesn't match Password")

  end

end
