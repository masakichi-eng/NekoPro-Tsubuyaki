require 'rails_helper'

RSpec.describe "Users::Posts", type: :request do

  before do
    User.create(id: 1, name: 'test')
  end

  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_users_post_path
      expect(response.status).to eq 200
    end
  end
  
  describe 'POST #create' do
    context 'パラメータが正常な場合' do
      it 'リクエストが成功すること' do
        post users_post_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.status).to eq 302 
      end

      it '記事が登録されること' do
        expect{
          post users_post_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        }.to change(Post, :count).by(1)
      end

      it 'リダイレクトされること' do
        post users_post_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response).to redirect_to root_path
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post users_post_path, params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.status).to eq 200
      end

      it 'ユーザーが登録されないこと' do
        expect{
        post users_post_path, params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        }.to_not change(Post, :count)
      end

      it 'エラーが表示されること' do
        post users_post_path, params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.body).to include "Description can&#39;t be blank"
      end

    end
  end
end