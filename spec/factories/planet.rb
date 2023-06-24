FactoryBot.define do
  factory :planet do
    name { Faker::Lorem.sentence(word_count: 2) }
    diameter { Faker::Lorem.sentence(word_count: 2) }
    rotation_period { Faker::Lorem.sentence(word_count: 2) }
    orbital_period { Faker::Lorem.sentence(word_count: 2) }
    gravity { Faker::Lorem.sentence(word_count: 2) }
    population { Faker::Lorem.sentence(word_count: 2) }
    climate { Faker::Lorem.sentence(word_count: 2) }
    terrain { Faker::Lorem.sentence(word_count: 2) }
    surface_water { Faker::Lorem.sentence(word_count: 2) }
  end
end
