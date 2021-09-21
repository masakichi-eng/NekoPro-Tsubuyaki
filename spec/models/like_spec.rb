require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#create' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }
    let(:like) { FactoryBot.build(:like, user: user, post: post) }

    context '成功する場合' do
      it '全て揃っている場合' do
        expect(like).to be_valid
      end
    end
    context '失敗する場合' do
      it 'ユーザーidがない場合' do
        like.user_id = nil
        like.valid?
        expect(like.errors.full_messages).to include("User must exist")
      end
      it 'ポストidがない場合' do
        like.post_id = nil
        like.valid?
        expect(like.errors.full_messages).to include("Post must exist")
      end
    end
  end
end
