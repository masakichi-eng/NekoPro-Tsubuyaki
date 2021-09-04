require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { User.create(id: 1, name: 'test') }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:post2) { FactoryBot.create(:post, user: user) }
  let(:like) { FactoryBot.build(:like, user: user, post: post) }
  let!(:like2) { FactoryBot.create(:like, user: user, post: post2)}

  describe "POST #create" do
    it 'リクエストが成功すること' do
      post users_post_likes_path(like.post_id), xhr: true
      expect(response).to be_truthy
    end
    it 'いいねが成功してモデルが増えること' do
      expect do
        post users_post_likes_path(like.post_id), xhr: true
      end.to change(Like, :count).by(1)
    end
  end
  
  describe "delete #destroy" do
    it 'リクエストが成功すること' do
      delete users_post_likes_path(like2.post_id), xhr: true
      expect(response).to be_truthy
    end
    it 'いいね解除が成功してモデルが減ること' do
      expect do
        delete users_post_likes_path(like2.post_id), xhr: true
      end.to change(Like, :count).by(-1)
    end
  end
end