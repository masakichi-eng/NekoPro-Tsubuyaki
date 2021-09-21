require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:new_post) { FactoryBot.create(:post, user: user) }
  let(:new_post2) { FactoryBot.create(:post, user: user) }
  let(:like) { FactoryBot.build(:like, user: user, post: new_post) }
  let!(:like2) { FactoryBot.create(:like, user: user, post: new_post2)}
  let(:post_likes) { users_post_likes_path(like.post_id) }
  let(:post_likes2) { users_post_likes_path(like2.post_id) }

  before do
    sign_in user
  end

  describe "POST #create" do
    it 'リクエストが成功すること' do
      post post_likes, xhr: true
      expect(response).to be_truthy
    end
    it 'いいねが成功してモデルが増えること' do
      expect do
        post post_likes, xhr: true
      end.to change(Like, :count).by(1)
    end
  end
  
  describe "delete #destroy" do
    it 'リクエストが成功すること' do
      delete post_likes2, xhr: true
      expect(response).to be_truthy
    end
    it 'いいね解除が成功してモデルが減ること' do
      expect do
        delete post_likes2, xhr: true
      end.to change(Like, :count).by(-1)
    end
  end
end