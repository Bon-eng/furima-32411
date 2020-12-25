FactoryBot.define do
  factory :user do
    nickname           { 'yamada' }
    email              { Faker::Internet.free_email }
    password           { 'a11111' }
    encrypted_password { 'a11111' }
    last_name          { '山田' }
    first_name         { '太郎' }
    last_name_kana     { 'ヤマダ' }
    first_name_kana    { 'タロウ' }
    birthday           { '1930-10-10' }
  end
end
