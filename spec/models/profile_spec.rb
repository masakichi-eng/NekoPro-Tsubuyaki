require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'ユーザー登録機能' do
    before do
      @profile = FactoryBot.build(:profile)
    end

    context 'プロフィールが登録できるとき' do
      it 'すべての項目が入力されているとき、プロフィールが登録できる' do
        expect(@profile).to be_valid
      end
    end

    context 'プロフィールが登録できないとき' do
      it 'last_nameが空だとプロフィールが登録できない' do
        @profile.last_name = ""
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameがアルファベットだと登録できない' do
        @profile.last_name = "aiueo"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Last name is invalid")
      end

      it 'first_nameが空だとプロフィールが登録できないとき' do
        @profile.first_name = ""
        @profile.valid?
        expect(@profile.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameがアルファベットだと登録できない' do
        @profile.first_name = "aiueo"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("First name is invalid")
      end

      it 'last_name_kanaが空だとプロフィールが登録できないとき' do
        @profile.last_name_kana = ""
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'last_name_kanaがアルファベットだと登録できない' do
        @profile.last_name_kana = "aiueo"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'last_name_kanaがひらがなだと登録できない' do
        @profile.last_name_kana = "あいうえお"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'last_name_kanaが漢字だと登録できない' do
        @profile.last_name_kana = "愛上大"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'first_name_kanaが空だとプロフィールが登録できないとき' do
        @profile.first_name_kana = ""
        @profile.valid?
        expect(@profile.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaがアルファベットだと登録できない' do
        @profile.first_name_kana = "aiueo"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("First name kana is invalid")
      end

      it 'first_name_kanaがひらがなだと登録できない' do
        @profile.last_name_kana = "あいうえお"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'first_name_kanaが漢字だと登録できない' do
        @profile.last_name_kana = "愛上大"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'birth_dateが空だとプロフィールを登録できないとき' do
        @profile.birth_date = ""
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
