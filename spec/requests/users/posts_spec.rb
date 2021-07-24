require 'rails_helper'

RSpec.describe "Users::Posts", type: :request do

  before do
    @post = FactoryBot.create(:post)
  end

  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_users_post_path
      expect(response.status).to eq 200
    end
  end
  
  describe 'POST #create' do
    it 'リクエストが成功すること' do
      User.create(id: 1, name: 'test')
      post users_post_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
      expect(response.status).to eq 302 
    end

    it '記事が登録されること' do
      User.create(id: 1, name: 'test')
      expect{
        post users_post_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
      }.to change(Post, :count).by(1)
    end

    it 'リダイレクトされること' do
      User.create(id: 1, name: 'test')
      post users_post_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
      expect(response).to redirect_to root_path
    end
  end
end