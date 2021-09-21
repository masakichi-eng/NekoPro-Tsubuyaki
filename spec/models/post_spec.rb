require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.build(:post, user: @user)
    end

    context '投稿成功する場合' do
      it '全て揃っていれば投稿できる' do
        expect(@post).to be_valid
      end

      it 'descriptionが140文字以内であれば投稿できる' do
        @post.description = 's' * 140
        expect(@post).to be_valid
      end
    end
    
    context '投稿失敗する場合' do
      it 'descriptionが空だと投稿できない' do
        @post.description = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Description can't be blank")
      end

      it 'descriptionが140文字を超えていると投稿できない' do
        @post.description = 's' * 141
        @post.valid?
        expect(@post.errors.full_messages).to include("Description is too long (maximum is 140 characters)")
      end
    
      it 'photoが空だと投稿できない' do
        @post.photo = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Photo can't be blank")
      end

      it 'userが空だと投稿できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("User must exist")
      end
    end

  end
end
