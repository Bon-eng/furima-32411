require 'rails_helper'

RSpec.describe User, type: :model do
  # build(:user)に入っている正規表現のバリデーションとFactoryBotの情報を@userに代入、インスタンス生成を共通化
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録がうまくいくとき'
    it '記入欄の全てが存在すれば登録できる' do
      expect(@user).to be_valid
    end
  end

  # binding.pry

  context '新規登録がうまくいかないとき' do
    it 'nicknameが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it 'emailが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it 'emailが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'emailは@を含むこと' do
      @user.email = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールは不正な値です")
    end

    it 'passwordが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは不正な値です")
    end

    it 'passwordが6文字以上必須であること' do
      @user.password = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードは不正な値です")
    end

    it 'passwordが半角数字のみの場合登録できない' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です")
    end

    it 'passwordが半角英字のみの場合登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です")
    end

    it 'passwordが全角英数字のみの場合登録できない' do
      @user.password = 'Ａ１１１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です")
    end

    it 'passwordとpassword確認用の値が一致していないと登録できない' do
      @user.password = 'a11111'
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

    it 'last_nameが必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(名字)を入力してください", "お名前(名字)は不正な値です")
    end

    it 'first_nameが必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(名前)を入力してください")
    end

    it 'last_nameが全角漢字、カタカナ、ひらがなでの入力が必須であること' do
      @user.last_name = 'a1#'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(名字)は不正な値です")
    end

    it 'first_nameが全角漢字、カタカナ、ひらがなでの入力が必須であること' do
      @user.first_name = 'a1#'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(名前)は不正な値です")
    end

    it 'last_name_kanaが必須であること' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名字)を入力してください", "お名前カナ(名字)は不正な値です")
    end

    it 'first_name_kanaが必須であること' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名前)を入力してください", "お名前カナ(名前)は不正な値です")
    end

    it 'last_name_kanaが全角カタカナでの入力が必須であること' do
      @user.last_name_kana = 'a1あ'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名字)は不正な値です")
    end

    it 'first_name_kanaが全角カタカナでの入力が必須であること' do
      @user.first_name_kana = 'a1あ'
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前カナ(名前)は不正な値です")
    end

    it 'birthdayが必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end
end
