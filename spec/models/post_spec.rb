require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @post = FactoryBot.build(:post)
    end

    context '投稿成功する場合' do
      it '全て揃っていれば投稿できる' do
        expect(@post).to be_valid
      end

      it 'descriptionが140文字以内であれば投稿できる' do
        @post.description = '123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/'
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
        @post.description = '123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/123456789/a'
        @post.valid?
        expect(@post.errors.full_messages).to include("Description is too long (maximum is 140 characters)")
      end
    
      it 'photoが空だと投稿できない' do
        @post.photo = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Photo can't be blank")
      end
    end

  end
end
