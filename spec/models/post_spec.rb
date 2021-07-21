require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @post = FactoryBot.build(:post)
    end
  
    it '全て揃っていれば投稿できる' do
      expect(@post).to be_valid
    end
  
    it 'descriptionが空だと投稿できない' do
      @post.description = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("Description can't be blank")
    end
  
    it 'photoが空だと投稿できない' do
      @post.photo = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("Photo can't be blank")
    end
    
  end
end
