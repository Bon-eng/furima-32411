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
      expect(@item.errors.full_messages).to include("出品画像を入力してください")
    end

    it '商品名が必須であること' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end

    it '商品の説明が必須であること' do
      @item.introduction = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の説明を入力してください")
    end

    it 'カテゴリーに情報を入れないと登録できない' do
      @item.category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("カテゴリーを入力してください", "カテゴリーを入力してください")
    end

    it 'カテゴリーの情報が必須であること' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
    end

    it '商品の状態に情報を入れないと登録できない' do
      @item.status_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の状態を入力してください", "商品の状態を入力してください")
    end

    it '商品の状態の情報が必須であること' do
      @item.status_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の状態を入力してください")
    end

    it '配送料の負担に情報を入れないと登録できない' do
      @item.postage_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("配送料の負担を入力してください", "配送料の負担を入力してください")
    end

    it '配送料の負担の情報が必須であること' do
      @item.postage_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
    end

    it '発送元の地域に情報を入れないと登録できない' do
      @item.prefecture_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("発送元の地域を入力してください", "発送元の地域を入力してください")
    end

    it '発送元の地域の情報が必須であること' do
      @item.prefecture_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
    end

    it '発送までの日数に情報を入れないと登録できない' do
      @item.days_to_ship_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("発送までの日数を入力してください", "発送までの日数を入力してください")
    end

    it '発送までの日数の情報が必須であること' do
      @item.days_to_ship_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
    end

    it '価格に情報を入れないと登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("販売価格を入力してください", "販売価格は不正な値です", "販売価格は数値で入力してください")
    end

    it '価格の範囲が、¥299以下だと登録できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
    end

    it '価格の範囲が、¥10,000,000以上だと登録できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
    end

    it '価格について全角文字では登録できないこと' do
      @item.price = '１１１１'
      @item.valid?
      expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
    end

    it '価格について半角英数混合では登録できないこと' do
      @item.price = '300a'
      @item.valid?
      expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
    end

    it '価格について半角英語だけでは登録できないこと' do
      @item.price = 'pomepome'
      @item.valid?
      expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
    end
  end
end
