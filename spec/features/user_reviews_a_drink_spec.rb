require "rails_helper"

feature "User creates a review for a drink" %{
  As an authenticated user
  I want to write a review for a specific drink
  So that others can see my opinion
  } do

    # Acceptance Criteria
    # [] I must be logged in to write a review
    # [] I must provide a rating from 1-5
    # [] If a drink is non-alcoholic, my rating must not exceed 3
    # [] When I am on a drink's page, I can enter my review
    # [] I can optionally provide a title for the review
    # [] I can optionally provide a body for the review
    # [] If I submit my review successfully, it appears in the reviews page
    # [] If I enter invalid information, I am presented with an error message
    # and taken back to the drink page


    scenario "user reviews an alcoholic drink - with title and body" do
      user = FactoryGirl.create(:user)
      drink = FactoryGirl.create(:alcohol_drink)
      review = FactoryGirl.build(:alcohol_drink_review)

      visit drink_path(drink)

      click_on "Write a review of #{drink}"

      choose "review_rating_#{review.rating}"
      fill_in "Title", :with review.title
      fill_in "Body", :with review.body

      click_on "Submit"

      expect(page).to have_content "Successfully added your review"
      expect(page).to have_content "#{drink} Reviews"
      expect(page).to have_content review.title
      expect(page).to have_content review.body
      expect(page).to have_content review.rating

    end
    scenario "user reviews an alcoholic drink - without title and body"
    scenario "user reviews a non-alcoholic drink - with title and body"
    scenario "user reviews a non-alcoholic drink - without title and body"
    scenario "user provides invalid information - no rating"
    scenario "user provides invalid information - rating greater than 3 for non-
    alcoholic drink"
    scenario "visitor tries to review a drink"


  end
