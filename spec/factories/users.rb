FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number: 2)}
    email {Faker::Internet.free_email}
    password { '1a' + Faker::Internet.password(min_length: 4)}
    password_confirmation {password}
    first_name {'山田'}
    last_name {'太郎'}
    first_name_kana {'ヤマダ'}
    last_name_kana {'タロウ'}
    birthday { '1930-01-31' }
  end
end