# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

propertyTypes = ['house', 'apartment', 'guesthouse', 'hote']
continents = ['North America', 'South America', 'Europe', 'Asia', 'Africa', 'Australia']

(1..100).each do |id|
    Property.create!(
        category: propertyTypes.sample,
        continent: continents.sample,
        country: Faker::Address.country,
        city: Faker::Address.city,
        neighbourhood: Faker::Address.full_address,
        name: Faker::Name.name,
        description: Faker::Markdown.emphasis,
        facilities: Faker::Markdown.emphasis,
        rating: Faker::Number.decimal(l_digits: 1),
        reviews: Faker::Number.number(digits: 5),
        guests: (1..4),
        bedrooms: (1..3),
        beds: (1..3),
        baths: (1..3),
        price: Faker::Number.number(digits: 4),
        currency: Faker::Currency.code,
        is_available: [true, false].sample,
    )
end   
