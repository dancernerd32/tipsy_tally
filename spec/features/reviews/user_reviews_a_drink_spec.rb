require "rails_helper"

feature "User creates a review for a drink", %{
  As an authenticated user
  I want to write a review for a specific drink
  So that others can see my opinion
  } do

    # Acceptance Criteria
    # [x] I must be logged in to write a review
    # [x] I must provide a rating from 1-5
    # [] If a drink is non-alcoholic, my rating must not exceed 3
    # [x] When I am on a drink's page, I can enter my review
    # [x] I can optionally provide a title for the review
    # [x] I can optionally provide a body for the review
    # [x] If I submit my review successfully, it appears in the reviews page
    # [x] If I enter invalid information, I am presented with an error message
    #     and taken back to the drink page

    context "user is signed in" do

      before(:each) do

        @existing_user = FactoryGirl.create(:user)

        visit new_user_session_path

        fill_in "Login", with: @existing_user.email
        fill_in "Password", with: @existing_user.password

        click_button "Log in"
      end

      scenario "user reviews a drink - with title and body" do

        ActionMailer::Base.deliveries = []

        review = FactoryGirl.build(:review)
        review_drink = review.drink

        visit drink_path(review_drink)

        choose "review_rating_3"
        fill_in "Title", with: review.title
        fill_in "Body", with: review.body

        click_on "Submit"

        expect(page).to have_content "Successfully added your review"
        expect(page).to have_content "#{review_drink.name} Reviews"
        expect(page).to have_content review.title
        expect(page).to have_content review.body
        expect(page).to have_content review.rating

        expect(ActionMailer::Base.deliveries.size).to eql(1)
        last_email = ActionMailer::Base.deliveries.last


      end

      scenario "user provides invalid information - no rating" do

        review = FactoryGirl.build(:review)
        review_drink = review.drink

        visit drink_path(review_drink)

        click_on "Submit"

        expect(page).to have_content "Rating can't be blank"
        expect(page).to have_content review_drink.name

      end
    end

    scenario "visitor tries to review a drink" do
      review = FactoryGirl.build(:review)
      review_drink = review.drink

      visit drink_path(review_drink)

      choose "review_rating_3"
      fill_in "Title", with: review.title
      fill_in "Body", with: review.body

      click_on "Submit"

      expect(page).to have_content "You must sign in or sign up to leave
       a review"
      expect(page).to have_selector("input", review.title)

    end

  end
