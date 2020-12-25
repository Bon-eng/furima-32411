class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ActiveHashでbelongs_toをそれぞれのモデルに設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :days_to_ship

  # プルダウンが「---」を選択している時も登録できないようにするバリデーション
  # バリデーションをかけるときは↪改行して一行ずつ書いていくこと
  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :price, format: { with: /\A[0-9]+\z/ },
                      numericality: {
                        greater_than_or_equal_to: 300,
                        less_than_or_equal_to: 9_999_999
                      }
  end
  
  #presence: trueの入れ子にしてしまうとテストコードでわけわからなくなるので別々にして解決した
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

end
