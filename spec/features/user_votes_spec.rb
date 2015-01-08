require "rails_helper"

feature "User votes on a reivew", %{
  As a user,
  I want to be able to vote wether a review was helpful or not,
  so that I can help others choose a drink
  } do
    # Acceptance Criteria:
    # [] When I'm logged in, I can click a button on a review to up vote
    # [] When I'm logged in, I can click a button on a review to down vote
    # [] If I have already up voted, I can change my vote to a down vote.
    # [] If I have already down voted, I can change my vote to an up vote
    # [] I can not up vote or down vote the same review twice
    # [] I must be signed in to cast a vote
    # [] If I click the down vote or up vote button a second time,
    #     I delete my vote.

  context "User is signed in" do
    before(:each) do
      @existing_user = FactoryGirl.create(:user)
      @review = FactoryGirl.create(:review)
      visit new_user_session_path

      fill_in "Login", with: @existing_user.username
      fill_in "Password", with: @existing_user.password

      click_button "Log in"

      visit drink_path(@review.drink)
    end

    scenario "User clicks the upvote button" do

      click_on "+1"

      expect(page).to have_content "Score: 1"
    end

    scenario "User clicks the downvote button" do

      click_on "-1"

      expect(page).to have_content "Score: -1"
    end
  end
end
