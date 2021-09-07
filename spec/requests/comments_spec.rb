require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { User.create(id: 1, name: 'test') }
  let(:created_post) { FactoryBot.create(:post, user: user) }
  let(:build_comment) { FactoryBot.build(:comment, post: created_post) }
  let(:created_comment) { FactoryBot.create(:comment, user: user, post: created_post)}
  let(:path_build_comment) { users_post_comments_path(build_comment.post_id) }
  let!(:path_created_comment) { users_post_comment_path(created_comment.post_id, created_comment) }

  describe "POST #create" do
    it 'リクエストが成功すること' do
        post path_build_comment, params: { comment: {comment: build_comment }}, xhr: true
      expect(response).to be_truthy
    end
    it 'コメント投稿が成功してモデルが増えること' do
      expect do
        post path_build_comment, params: { comment: {comment: build_comment }}, xhr: true
      end.to change(Comment, :count).by(1)
    end
  end
  
  describe "DELETE #destroy" do
    it 'リクエストが成功すること' do
      delete path_created_comment, xhr: true
      expect(response).to be_truthy
    end
    it 'コメント削除が成功してモデルが減ること' do
      expect do
        delete path_created_comment, xhr: true
      end.to change(Comment, :count).by(-1)
    end
  end
end
