FactoryBot.define do
  factory :purchase_address do
    postal_code { '123-4567'}
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    town {'東京都' }
    plot_number { '1-1' }
    building { Faker::Lorem.word }
    phone_number { '09012345678'}
    token { "tok_abcdefghijk00000000000000000" }
    association :user
    association :item
  end
end
