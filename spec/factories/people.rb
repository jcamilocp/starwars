FactoryBot.define do
  factory :people do
    name { Faker::Lorem.sentence(word_count: 2) }
    birth_year { Faker::Lorem.sentence(word_count: 2) }
    eye_color { Faker::Lorem.sentence(word_count: 2) }
    gender { Faker::Lorem.sentence(word_count: 2) }
    hair_color { Faker::Lorem.sentence(word_count: 2) }
    height { Faker::Lorem.sentence(word_count: 2) }
    mass { Faker::Lorem.sentence(word_count: 2) }
    skin_color { Faker::Lorem.sentence(word_count: 2) }
    planet_id nil
  end
end
