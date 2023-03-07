# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

propertyTypes = ['house', 'apartment', 'guesthouse', 'hote']
continents = ['North America', 'South America', 'Europe', 'Asia', 'Africa', 'Australia']

User.create(
    first_name: 'John',
    last_name: 'Doe',
    email: 'doe@email.com',
    password: 'aaaaaaaa',
)

(1..100).each do |id|
    Property.create(
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
        guests: rand(4),
        bedrooms: rand(3),
        beds: rand(3),
        baths: rand(3),
        price: Faker::Number.number(digits: 4),
        currency: Faker::Currency.code,
        is_available: [true, false].sample,
        user_id: 1,
    )
end   
