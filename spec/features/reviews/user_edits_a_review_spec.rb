require "rails_helper"
feature "user edits a review", %{
	As a user,
	I want to update my review
	So that I can edit an error, add a review body(or title), or change my opinion
  } do

  # Acceptance Critieria:
  # [] I must be logged in
  # [] I can only edit my own review
  # [x] I can change the review body
  # [x] I can change the review title
  # [x] I can change the rating
  # [] If I successfully update my comment I am a shown a success message
 	# 	 and taken to the drink's show page

	context "authenticated user" do
	  before(:each) do
	    @user1 = FactoryGirl.create(:user)

	    visit root_path

	    click_on "Sign In"

	    fill_in "Login", with: @user1.email
	    fill_in "Password", with: @user1.password
	    click_on "Log in"
	  end

	  scenario "User updates a review successfully with title & body" do

	  	review = FactoryGirl.create(:review, user: @user1)
	  	drink = Drink.find(review.drink_id)

	  	visit drink_path(drink)

	  	click_on "Edit review"

	  	choose "review_rating_1"
	  	fill_in "Title", with: "New Title"
	  	fill_in "Body", with: "New Body"

			click_on "Update"

	  	expect(page).to have_content "New Title"
	  	expect(page).to have_content "New Body"
	  	expect(page).to have_content "1"
	  	expect(page).not_to have_content review.title
			expect(page).to have_content "Review updated successfully!"
			expect(page).to have_content drink.description

	  end

		scenario "User tries to update another user's review" do

			review = FactoryGirl.create(:review)
			drink = Drink.find(review.drink_id)

			visit drink_path(drink)

			expect(page).not_to have_link("Edit review",
			href: edit_drink_review_path(drink, review))

			visit edit_drink_review_path(drink, review)

			expect(page).to have_content "You cannot edit someone else's review"
			expect(page).to have_content drink.description

		end
	end

	scenario "unauthenticated user tries to update a review" do

		review = FactoryGirl.create(:review)
		drink = Drink.find(review.drink_id)

		visit drink_path(drink)

		expect(page).not_to have_link("Edit review",
		href: edit_drink_review_path(drink, review))

		visit edit_drink_review_path(drink, review)

		expect(page).to have_content "You must be signed in to do that"
		expect(page).to have_content drink.description
	end

end
