FactoryBot.define do
  factory :film do
    title { Faker::Lorem.sentence(word_count: 2) }
    sequence(:episode_id) { |n| n }
    opening_crawl { Faker::Lorem.sentence(word_count: 2) }
    director { Faker::Lorem.sentence(word_count: 2) }
    producer { Faker::Lorem.sentence(word_count: 2) }
    release_date { Time.at(Time.now + rand * (0.0.to_f - Time.now.to_f)) }
  end
end
