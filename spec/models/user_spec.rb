require 'rails_helper'

RSpec.describe User, type: :model do
  #build(:user)に入っている正規表現のバリデーションとFactoryBotの情報を@userに代入、インスタンス生成を共通化
  before do
    @user = FactoryBot.build(:user)
  end

  describe'新規登録/ユーザー情報' do
    context'新規登録がうまくいくとき'
      it '記入欄の全てが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    #binding.pry
    
    context'新規登録がうまくいかないとき' do
      it 'nicknameが必須であること' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが必須であること' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@を含むこと' do
        @user.email = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが必須であること' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password is invalid")
      end
      it 'passwordが6文字以上必須であること' do
        @user.password = "11111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)", "Password is invalid")
      end
      it 'passwordが半角数字のみの場合登録できない' do
        @user.password = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordが半角英字のみの場合登録できない' do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordが全角英数字のみの場合登録できない' do
        @user.password = "Ａ１１１１１"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordとpassword確認用の値が一致していないと登録できない' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが必須であること' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
      end
      it 'first_nameが必須であること' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end
      it 'last_nameが全角漢字、カタカナ、ひらがなでの入力が必須であること' do
        @user.last_name = "a1#"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it 'first_nameが全角漢字、カタカナ、ひらがなでの入力が必須であること' do
        @user.first_name = "a1#"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'last_name_kanaが必須であること' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana is invalid")
      end
      it 'first_name_kanaが必須であること' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
      end
      it 'last_name_kanaが全角カタカナでの入力が必須であること' do
        @user.last_name_kana = "a1あ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it 'first_name_kanaが全角カタカナでの入力が必須であること' do
        @user.first_name_kana = "a1あ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it 'birthdayが必須であること' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end

end