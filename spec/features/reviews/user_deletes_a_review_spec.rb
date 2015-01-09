require "rails_helper"

feature "User deletes a review", %{
  As a user
  I want to delete my review
  So that I can change my mind about having a review
} do

  # Acceptance Criteria
  # [x] I must be logged in
  # [x] I can only delete my own review
  # [x] When I delete my review, I am taken to the drink page and given a success
  #    message

  context "authenticated user" do
    before(:each) do
      @user1 = FactoryGirl.create(:user)

      visit root_path

      click_on "Sign In"

      fill_in "Login", with: @user1.email
      fill_in "Password", with: @user1.password
      click_on "Log in"
    end

    scenario "User successfully deletes review" do
      review = FactoryGirl.create(:review, user: @user1)
      drink = Drink.find(review.drink_id)

      visit drink_path(drink)

      click_on "Delete"

      expect(page).to have_content "Successfully deleted review"
      expect(page).to have_content drink.description
      expect(page).not_to have_content review.title
      expect(page).not_to have_content "Average Rating:"

    end

    scenario "User cannot see delete option for another user's review" do
      review = FactoryGirl.create(:review)
      drink = Drink.find(review.drink_id)

      visit drink_path(drink)

      expect(page).not_to have_button("Delete")

    end

  end

  scenario "Unauthenticated user cannot see delete option" do

    review = FactoryGirl.create(:review)
    drink = Drink.find(review.drink_id)

    visit drink_path(drink)

    expect(page).not_to have_button("Delete")
  end

end
