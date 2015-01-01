# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Adds Liquors to the Liquor Database
  liquors = %w(Rum Vodka Whiskey Liqueur(s)
               Tequila Gin Scotch Cognac Brandy Other)
  liquors.each do |liquor_name|
    Liquor.find_or_create_by(name: liquor_name)
  end
