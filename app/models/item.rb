class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ActiveStorage使用でimageカラムとのバリデーションをする記述がこちら、内容が空だと登録できないようにするバリデーション

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
    validates :category_id, numericality: { other_than: 1 }
    validates :status_id, numericality: { other_than: 1 }
    validates :postage_id, numericality: { other_than: 1 }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :days_to_ship_id, numericality: { other_than: 1 }
  end
end
