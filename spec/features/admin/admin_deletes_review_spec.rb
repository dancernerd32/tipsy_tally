require "rails_helper"

feature "Admin deletes a review", %{
  As an admin,
  I want to be able to delete a review,
  So that I can moderate submissions
  } do

  # Acceptance Criteria:
  # [X] The review must be remvoved from the drink page
  # [X] After deleted review, I should be redirected to the drink page
  # [X] I should see a success message when a review is removed
  # [X] User can't see the button to delete a review
  # [X] Visitor can't see the button to delete a review

  context "Admin is signed in" do
    before(:each) do
      @admin1 = FactoryGirl.create(:user, role: "admin")
      visit root_path

      click_on "Sign In"

      fill_in "Login", with: @admin1.email
      fill_in "Password", with: @admin1.password
      click_on "Log in"
    end

    scenario "Admin deletes a review" do
      review = FactoryGirl.create(:review, body: "deleted review")

      visit drink_path(review.drink)

      click_on "Delete Review"

      expect(page).to_not have_content (review.body)
      expect(page).to have_content("Successfully Deleted Review")
      expect(page).to have_content(review.drink.name)
    end
  end

  scenario "Visitor does not see the delete button on reviews" do
    review = FactoryGirl.create(:review, body: "deleted review")

    visit drink_path(review.drink)

    expect(page).to_not have_content("Delete Review")
  end

  scenario "User does not see the delete button on reviews" do
    review = FactoryGirl.create(:review, body: "deleted review")

    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in "Login", with: user.username
    fill_in "Password", with: user.password

    click_button "Log in"

    visit drink_path(review.drink)

    expect(page).to_not have_content("Delete Review")
  end
end
