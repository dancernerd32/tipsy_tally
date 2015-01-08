require "rails_helper"

feature "User searches for a drink", %{
  As anyone 
  I want to search for a specific drink
  So I can see more information

  } do


    # Acceptance Criteria
    # [] I must see results related to my search
    # [] The results must contain links to their drinks
    # [] I will only see drink results

    scenario "User searches for a drink" do

    	FactoryGirl.create(:drink, name: "beer")
    	FactoryGirl.create(:drink, name: "wine")

    	visit root_path

    	fill_in "search", with: "beer"
    	click_on "Search"

    	expect(page).to have_link "beer"
    	expect(page).to_not have_link "wine"

   	end
	end