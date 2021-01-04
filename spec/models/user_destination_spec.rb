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
        expect(@user_destination.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は不正な値です")
      end

      it '郵便番号にはハイフンが必須であること' do
        @user_destination.post_code = '1234567'
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it '都道府県が1の場合購入できない' do
        @user_destination.prefecture_id = 1
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("都道府県を入力してください")
      end

      it '市町村区が必須であること' do
        @user_destination.city = ''
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("市区町村を入力してください", "市区町村は不正な値です")
      end

      it '番地が必須であること' do
        @user_destination.address = ''
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("番地を入力してください", "番地は不正な値です")
      end

      it '電話番号が必須であること' do
        @user_destination.phone_number = ''
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end

      it '電話番号にはハイフンは不要であること' do
        @user_destination.phone_number = '012-456-789'
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("電話番号は不正な値です")
      end

      it '電話番号が12桁以上では購入できない' do
        @user_destination.phone_number = '123456789012'
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("電話番号は不正な値です")
      end

      it '電話番号が英数字混合では購入できない' do
        @user_destination.phone_number = 'a234567890'
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'user_idがない場合は購入できない' do
        @user_destination.user_id = nil
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Userを入力してください")
      end

      it 'item_idがない場合は購入できない' do
        @user_destination.item_id = nil
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenが空では登録できない' do
        @user_destination.token = nil
        @user_destination.valid?
        expect(@user_destination.errors.full_messages).to include("Tokenを入力してください")
      end

    end
  end
end
