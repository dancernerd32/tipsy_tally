require "rails_helper"

feature "User votes on a reivew", %{
  As a user,
  I want to be able to vote wether a review was helpful or not,
  so that I can help others choose a drink
  } do
    # Acceptance Criteria:
    # [X] When I'm logged in, I can click a button on a review to up vote
    # [X] When I'm logged in, I can click a button on a review to down vote
    # [X] If I have already up voted, I can change my vote to a down vote.
    # [X] If I have already down voted, I can change my vote to an up vote
    # [X] I can not up vote or down vote the same review twice
    # [X] I must be signed in to cast a vote
    # [X] If I click the down vote or up vote button a second time,
    #   I delete my vote.
    # [X] The correct amount of votes is displayed

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

      click_on "Like"

      expect(page).to have_content "Score: 1"
    end

    scenario "User clicks the downvote button" do

      click_on "Dislike"

      expect(page).to have_content "Score: -1"
    end

    scenario "User resets their vote from up" do
      click_on "Like"
      click_on "Like"

      expect(page).to have_content "Score: 0"
    end

    scenario "User resets their vote from down" do
      click_on "Dislike"
      click_on "Dislike"

      expect(page).to have_content "Score: 0"
    end
  end

  scenario "visitor attempts to vote" do
    @review = FactoryGirl.create(:review)

    visit drink_path(@review.drink)

    click_on "Like"

    expect(page).to have_content("sign up before continuing")
  end

  scenario "There are multiple votes on a review" do
    upvoters = FactoryGirl.create_list(:user, 3)
    downvoters = FactoryGirl.create_list(:user, 2)
    review = FactoryGirl.create(:review)

    upvoters.each do |user|
      visit new_user_session_path

      fill_in "Login", with: user.username
      fill_in "Password", with: user.password

      click_button "Log in"

      visit drink_path(review.drink)

      click_on "Like"
      click_link "Sign Out"
    end

    visit drink_path(review.drink)

    expect(page).to have_content("Score: 3")

    downvoters.each do |user|
      visit new_user_session_path

      fill_in "Login", with: user.username
      fill_in "Password", with: user.password

      click_button "Log in"

      visit drink_path(review.drink)

      click_on "Dislike"
      click_link "Sign Out"
    end

    visit drink_path(review.drink)

    expect(page).to have_content("Score: 1")
  end
end
