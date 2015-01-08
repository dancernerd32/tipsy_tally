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

    FactoryGirl.create_list(:drink, 49)
    expected = FactoryGirl.create(:drink, name:"test")

    visit drinks_path
    click_on "5"
    
    expect(page).to have_link("test")

    click_on "test"
    expect(page).to have_content("This is a really good drink")
  end
end
