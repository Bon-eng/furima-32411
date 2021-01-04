class UserDestination
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchase_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :address, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :item_id
    validates :token
  end
  
  #都道府県はnumericalityヘルパーで記述
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id) #ここにtoken入ってエラーになってたよ、もう指定されてるから必要なし
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
      building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end

end