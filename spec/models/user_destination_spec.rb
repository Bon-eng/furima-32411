require 'rails_helper'

RSpec.describe UserDestination, type: :model do
  before do
    @user_destination = FactoryBot.build(:user_destination)
  end

  describe '新規登録/購入情報' do
    context '新規登録がうまくいくとき' do
      it '記入欄の全てが存在すれば登録できる' do
        expect(@user_destination).to be_valid
      end
      it '建物名が空でも購入できる' do
        @user_destination.building_name = ''
        @user_destination.valid?
      end
    end

  #binding.pry

    context '新規登録がうまくいかないとき' do
      it '郵便番号が必須であること' do
        @user_destination.post_code = ''
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号にはハイフンが必須であること' do
        @user_destination.post_code = '1234567'
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end

      it '都道府県が1の場合購入できない' do
        @user_destination.prefecture_id = 1
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Prefecture can't be blank.")
      end

      it '市町村区が必須であること' do
        @user_destination.city = ''
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("City can't be blank")
      end

      it '番地が必須であること' do
        @user_destination.address = ''
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が必須であること' do
        @user_destination.phone_number = ''
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号にはハイフンは不要であること' do
        @user_destination.phone_number = '012-456-789'
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Phone number is invalid. Input half-width characters.")
      end

      it 'user_idがない場合は購入できない' do
        @user_destination.user_id = nil
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idがない場合は購入できない' do
        @user_destination.item_id = nil
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では登録できない' do
        @user_destination.token = nil
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end
