class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do

  validates :nickname
  #全角ひらがな・カタカナ・漢字
  validates :last_name, format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name, format: {with: /\A[ぁ-んァ-ン一-龥]/}
  #全角カタカナ
  validates :last_name_kana, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :first_name_kana, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :birthday
  
  end
  #PASSWORD_REGEXをここで定義し、withの中で使う
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: {with: PASSWORD_REGEX}
  #パスワードが一致していなければいけない
  validates :password, confirmation: true

  
  has_many :items
  #has_many :purchases

end