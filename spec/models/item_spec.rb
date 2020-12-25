require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '新規登録/商品情報' do
    context '新規登録がうまくいくとき'
    it '記入欄の全てが存在すれば登録できる' do
      expect(@item).to be_valid
    end
  end

  context '新規登録がうまくいかないとき' do
    it '商品画像を1枚つけることが必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須であること' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が必須であること' do
      @item.introduction = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Introduction can't be blank")
    end

    it 'カテゴリーに情報を入れないと登録できない' do
      @item.category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
    end

    it 'カテゴリーの情報が必須であること' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Category must be other than 1")
    end

    it '商品の状態に情報を入れないと登録できない' do
      @item.status_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank", "Status is not a number")
    end

    it '商品の状態の情報が必須であること' do
      @item.status_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Status must be other than 1")
    end

    it '配送料の負担に情報を入れないと登録できない' do
      @item.postage_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Postage can't be blank", "Postage is not a number")
    end

    it '配送料の負担の情報が必須であること' do
      @item.postage_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Postage must be other than 1")
    end

    it '発送元の地域に情報を入れないと登録できない' do
      @item.prefecture_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
    end

    it '発送元の地域の情報が必須であること' do
      @item.prefecture_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
    end

    it '発送までの日数に情報を入れないと登録できない' do
      @item.days_to_ship_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Days to ship can't be blank", "Days to ship is not a number")
    end

    it '発送までの日数の情報が必須であること' do
      @item.days_to_ship_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Days to ship must be other than 1")
    end

    it '価格に情報を入れないと登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格の範囲が、¥300以下だと登録できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end

    it '価格の範囲が、¥9,999,999以上だと登録できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end

    it '価格について全角文字では登録できないこと' do
      @item.price = '１１１１'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it '価格について半角英数混合では登録できないこと' do
      @item.price = '300a'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it '価格について半角英語だけでは登録できないこと' do
      @item.price = 'pomepome'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

  end

end
