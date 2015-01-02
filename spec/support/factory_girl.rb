require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :alcohol_drink, class: Drink do
    sequence(:name) {|n| "Awesome drink #{n}"}
    description "This is a really good drink"
    user

    before(:create) do |drink|
      drink.liquors << Liquor.find(1)
      drink.liquors << Liquor.find(2)
    end
  end

  factory :non_alcohol_drink, class: Drink do
    sequence(:name) {|n| "Awesome drink #{n}"}
    description "This is a really good drink"
    alcoholic false
    user
  end

end
