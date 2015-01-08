require "rails_helper"

feature "visitor views drinks", %{
  As a visitor,
  I want to be able to view all drinks
  So I can decide which drink to look at
  } do

    # Acceptance Criteria:
    # [X] Vistor can see all the drinks listed on the homepage
    # [X] If I click a drink, it should bring me to the drinks details page

    scenario "vistor views the drinks and click on one" do
      drink = FactoryGirl.create(:drink, description: "This drink is awesome!")
      drink1 = FactoryGirl.create(:drink)

      visit drinks_path

      expect(page).to have_content(drink.name)
      expect(page).to have_content(drink1.name)

      click_on drink.name

      expect(page).to have_content(drink.liquors.first)
      expect(page).to have_content("This drink is awesome!")
    end
  end
