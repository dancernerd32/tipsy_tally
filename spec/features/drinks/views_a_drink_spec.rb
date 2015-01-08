require "rails_helper"

feature "User views a drink's details", %{
  As a visitor,
  I want to be able to see the details of a drink,
  so that I can decide if I want to have the drink
  } do
  # Acceptance Criteria:
  #
  # [X] I should see the name of the drink
  # [X] I should see the description of the drink
  # [X] If the drink has alcohol,
  #    I should see the types of alcohol used to make the drink
  # [X] If the drink is non-alcoholic, I don't see the liquors section
  # [X] I should see the average rating for the drink
  # [X] I should see the username and avatar of the person who added the drink

  scenario "Visitor views details of an alcoholic drink" do
    drink = FactoryGirl.create(:alcohol_drink)

    visit drink_path(drink)

    expect(page).to have_content drink.name
    expect(page).to have_content drink.description
    drink.liquors.each do |liquor|
      expect(page).to have_content liquor.name
    end

    expect(page).to have_content drink.user.username
    expect(page).not_to have_content "Edit Drink"
    expect(find('img')['src']).to have_content "default.jpg"
  end

  scenario "Visitor views details for a non-alcoholic drink" do
    drink = FactoryGirl.create(:drink)

    visit drink_path(drink)

    expect(page).not_to have_content "Liquors"
    expect(page).to have_content drink.name
    expect(page).to have_content drink.description
    expect(page).not_to have_content "Edit Drink"
  end

  scenario "Visitor views average rating for a drink" do
    drink = FactoryGirl.create(:drink)
    review = FactoryGirl.create(:review, rating: 1, drink: drink)
    review = FactoryGirl.create(:review, rating: 4, drink: drink)

    visit drink_path(drink)

    expect(page).to have_content("2.5")
  end
end
