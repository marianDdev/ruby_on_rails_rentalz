# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

property_types = ['house', 'apartment', 'guesthouse', 'hotel']

['owner', 'guest'].each do |role|
    @email = role + '@email.com'
    User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        role: role,
        email: @email,
        password: 'aaaaaaaa'
    )
end

CS.countries.each do |c|
    @country = Country.create(
        code: c[0],
        name: c[1]
    )
end

@countries = Country.all

@countries.each do |country|
    @cities = CS.get country.code
    @cities.each do |city|
        City.create(
            country_id: country.id,
            country_code: country.code,
            name: city[1]
        )
    end
end

@users = User.all

@countries.each do |country|
    country.cities.limit(3).each do |city|
        Property.create(
            user_id: @users.sample.id,
            category: property_types.sample,
            country: country.name,
            city: city.name,
            neighbourhood: Faker::Address.full_address,
            name: Faker::Name.name,
            description: Faker::Markdown.emphasis,
            facilities: Faker::Markdown.emphasis,
            guests: rand(4),
            bedrooms: rand(3),
            beds: rand(3),
            baths: rand(3),
            price: Faker::Number.number(digits: 4),
            currency: Faker::Currency.code,
            is_available: [true, false].sample,
    )
    end
end

