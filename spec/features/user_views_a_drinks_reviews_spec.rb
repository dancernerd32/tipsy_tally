require "rails_helper"

feature "User views a drink's reviews", %{
  As a visitor
  I want to see the reviews of a specific drink
  So that I know what other people think of it
  } do

  # Acceptance Criteria
  # [] I can see all of the reviews for a drink on the drink page
  # [] I can see the username and avatar for the reviewer of each review
  # [] I can see the timestamp for each review
  # [] I can see the rating for each review, and if a title and/or description
  #    were provided, I can see them as well
  # [] I can see the option to upvote and the option to downvote each review


  scenario "User visits a drink's review page"
  scenario "User tries to visit the review page for a drink with no reviews"

end
