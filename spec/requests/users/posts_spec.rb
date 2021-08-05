require 'rails_helper'

RSpec.describe Users::PostsController, type: :request do

  before do
    User.create(id: 1, name: 'test')
    @post = FactoryBot.create(:post)
    @not_post_id = @post.id + 1
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
        post users_posts_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response).to be_truthy
      end

      it '記事が登録されること' do
        expect{
          post users_posts_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        }.to change(Post, :count).by(1)
      end

      it 'リダイレクトされること' do
        post users_posts_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response).to redirect_to root_path
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post users_posts_path, params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.status).to eq 200
      end

      it '記事が登録されないこと' do
        expect{
        post users_posts_path, params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        }.to_not change(Post, :count)
      end

      it 'エラーが表示されること' do
        post users_posts_path, params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.body).to include "Description can&#39;t be blank"
      end

      
    end
  end

  describe 'GET #show' do
    context '記事が存在する場合' do

      it 'リクエストが成功すること' do
        get users_post_path @post.id
        expect(response.status).to eq 200
      end

      it '記事が表示されていること' do
        get users_post_path @post.id
        expect(response.body).to include @post.description
      end
    end

    context '記事が存在しない場合' do
      it 'リクエストが失敗すること' do
        expect {get users_post_path @not_post_id}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
  end

  describe 'GET #edit' do
    it 'リクエストが成功すること' do
      get edit_users_post_path @post
      expect(response.status).to eq 200
    end
  end

  describe 'PUT #update' do
    context 'パラメータが正常な場合' do
      it 'リクエストが成功すること' do
        patch users_post_path(id: @post.id), params: {post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response).to be_truthy
      end

      it '記事が登録されること' do
        expect{
          put users_post_path(id: @post.id), params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        }.to_not change(Post, :count)
      end

      it 'リダイレクトされること' do
        put users_post_path(id: @post.id), params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response).to redirect_to users_post_path(@post)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put users_post_path(id: @post.id), params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.status).to eq 200
      end

      it '記事が登録されないこと' do
        expect{
        put users_post_path(id: @post.id), params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        }.to_not change(Post, :count)
      end

      it 'エラーが表示されること' do
        put users_post_path(id: @post.id), params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.body).to include "Description can&#39;t be blank"
      end

      
    end
  end

end