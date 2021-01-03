FactoryBot.define do
  factory :user_destination do
    
    post_code      { '123-4567' }
    prefecture_id  { 2 }
    city           { '港区' }
    address        { '高輪1-11-11' }
    building_name  { '早川ハイツ' }
    phone_number   { '01234567890' }
    user_id        { 1 }
    item_id        { 1 }
    token          {"tok_abcdefghijk00000000000000000"}

  end
end
