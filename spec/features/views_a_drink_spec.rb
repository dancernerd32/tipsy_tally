require "rails_helper"

feature "User views a drink's details", %Q{
  As a visitor,
  I want to be able to see the details of a drink,
  so that I can decide if I want to have the drink
  } do
  # Acceptance Criteria:
  #
  # [] I should see the name of the drink
  # [] I should see the description of the drink
  # [] If the drink has alcohol,
  #    I should see the types of alcohol used to make the drink
  # [] If the drink is non-alcoholic, I don't see the liquors section
  # [] If there are at least 2 reviews,
  #    I should see the two most helpful reviews on the drink page
  # [] I should see the average rating for the drink
  # [] There should be a link to all reviews of that drink
  # [] I should see the username and avatar of the person who added the drink

  scenario "Visitor views details of an alcoholic drink" do
    drink = FactoryGirl.build(:drink)
    DrinkLiquor.create(drink_id: drink.id, liquor_id: 1)
    DrinkLiquor.create(drink_id: drink.id, liquor_id: 2)
    drink.save

    visit drink_path

    expect(page).to have_content drink.name
    expect(page).to have_content drink.description
    expect(page).to have_content drink.liquors

    ###############CHANGE TO USERNAME#######################
    expect(page).to have_content drink.user.email
  end

end
