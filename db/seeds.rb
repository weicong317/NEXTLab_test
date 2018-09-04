require 'faker'

500.times do 
  Service.create(
    name: Faker::Name.name, 
    price: rand(500),
    cost: rand(500),
    country: Faker::Address.country
  )
end