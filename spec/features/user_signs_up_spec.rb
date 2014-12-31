require 'rails_helper'

feature 'user registers', %Q{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # * I must specify a valid email address,
  #   password, and password confirmation
  # * If I don't specify the required information, I am presented with
  #   an error message

  scenario 'provide valid registration information - no avatar' do
    visit new_user_registration_path

    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'Username', with: 'John'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide valid registration information - with avatar'

  scenario 'provide invalid registration information - field left empty' do
    visit new_user_registration_path

    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'provide invalid registration information - email not unique' do

    user = FactoryGirl.create(:user)

    visit new_user_registration_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'Username', with: 'John'

    click_button 'Sign up'

    expect(page).to have_content("Email has already been taken")

  end

  scenario 'provide invalid registration information - username not unique' do

    user = FactoryGirl.create(:user)

    visit new_user_registration_path

    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'Username', with: user.username

    click_button 'Sign up'

    expect(page).to have_content('Username has already been taken')

  end

  scenario 'provide invalid registration information - password does not match confirmation' do

    visit new_user_registration_path

    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: '1password'
    fill_in 'Username', with: "John"

    click_button 'Sign up'
    expect(page).to have_content("Password confirmation doesn't match Password")

  end

end
