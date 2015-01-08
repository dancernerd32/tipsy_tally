require "rails_helper"

describe Drink do
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:drink_liquors).dependent(:destroy) }

	context "searching" do
		before(:each) do
			@rumandcoke = FactoryGirl.create(:drink, name: "Rum and Coke")
			@ginandtonic = FactoryGirl.create(:drink, name: "Gin and Tonic")
			@sangria = FactoryGirl.create(:drink, name: "Sangria")
		end

  	it "searches by drink name" do
  		results = Drink.search("Gin")

  		expect(results).to include(@ginandtonic)
  		expect(results).to_not include(@sangria)
  		expect(results).to_not include(@rumandcoke)
  	end
	end
end
