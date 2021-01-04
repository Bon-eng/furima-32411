class User < ApplicationRecord

  has_many :items
  has_many :purchases
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力して下さい'} do
    # 全角ひらがな・カタカナ・漢字
    validates :last_name
    validates :first_name
  end
  
  with_options presence: true do
    # 全角カタカナ
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  end
  
  with_options presence: true do
    validates :nickname
    validates :birthday
  end
  # PASSWORD_REGEXをここで定義し、withの中で使う
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX }
  # パスワードが一致していなければいけない
  validates :password, confirmation: true

end
