FactoryBot.define do
  factory :item do
    title {Faker::Lorem.word}
    description {Faker::Lorem.sentence}
    price {Faker::Number.within(range: 300..9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io:File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    category_id {Faker::Number.between(from: 2, to: 11)}
    item_status_id {Faker::Number.between(from: 2, to: 7)}
    delivery_fee_id {Faker::Number.between(from: 2, to: 3)}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    delivery_days_id {Faker::Number.between(from: 2, to: 4)}
  end    
end

