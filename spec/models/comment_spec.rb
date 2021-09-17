require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    let(:user) { User.create(name: 'test') }
    let(:post) { FactoryBot.create(:post) }
    let(:comment) { FactoryBot.build(:comment, user: user, post: post) }

    context '成功する場合' do
      it '全て揃っている場合' do
        expect(comment).to be_valid
      end
    end
    context '失敗する場合' do
      it 'user_idがない場合' do
        comment.user_id = nil
        comment.valid?
        expect(comment.errors.full_messages).to include("User must exist")
      end
      it 'post_idがない場合' do
        comment.post_id = nil
        comment.valid?
        expect(comment.errors.full_messages).to include("Post must exist")
      end
      it 'コメントがない場合' do
        comment.comment = nil
        comment.valid?
        expect(comment.errors.full_messages).to include("Comment can't be blank")
      end
    end
  end
end
