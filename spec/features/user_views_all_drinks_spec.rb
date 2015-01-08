require "rails_helper"

feature "visitor views drinks", %{
  As a visitor,
  I want to be able to view all drinks
  So I can decide which drink to look at
  } do

    # Acceptance Criteria:
    # [X] Vistor can see all the drinks listed on the homepage
    # [X] Drinks are listed ten at a time and are paginated
    # [X] If I click a drink, it should bring me to the drinks details page

  scenario "vistor selects a drink from within a paginated index view" do

    FactoryGirl.create_list(:drink, 50)

    visit drinks_path
    click_on "4"

    expect(page).to have_link("Awesome drink 40")

    click_on "Awesome drink 40"
    expect(page).to have_content("This is a really good drink")

  end
end
