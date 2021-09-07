require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録機能' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'ユーザー登録ができるとき' do
      it 'すべての項目を入力していれば登録できる' do
        expect(@user).to be_valid
      end

      it 'nicknameが空でも登録できる' do
        @user.nickname = ""
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録ができないとき' do
      it 'emailが空だと登録ができないとき' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailがすでに登録されている情報を登録しようとしてもできない' do
        @another_user = FactoryBot.create(:user)
        @user.email = @another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空だと登録ができない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが英字のみだと登録ができない" do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordが数字のみだと登録ができない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordが全角英数字だと登録ができない' do
        @user.password = 'ＡＡＡＡＡ００'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'password_confirmationが空だと登録ができない' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが一致しないと登録ができない' do
        @user.password_confirmation = 'saaaple00'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
