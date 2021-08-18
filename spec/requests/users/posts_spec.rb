require 'rails_helper'

RSpec.describe Users::PostsController, type: :request do

  before do
    User.create(id: 1, name: 'test')
    @post = FactoryBot.create(:post, user_id: 1)
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
        put users_post_path(id: @post.id), params: {post: {description: 'edit description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response).to be_truthy
      end

      it '記事が編集されること' do
        put users_post_path(id: @post.id), params: { post: {description: 'edit description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(Post.find(@post.id).description).to eq('edit description')
      end

      it 'リダイレクトされること' do
        put users_post_path(id: @post.id), params: { post: {description: 'edit description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response).to redirect_to users_post_path(@post)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功するがデータは編集されないこと' do
        put users_post_path(id: @post.id), params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.status).to eq 200
        expect(Post.find(@post.id).description).to eq(@post.description)
      end

      it '記事が編集されないこと' do
        put users_post_path(id: @post.id), params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(Post.find(@post.id).description).to eq(@post.description)
      end

      it 'エラーが表示されること' do
        put users_post_path(id: @post.id), params: { post: {description: nil, photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
        expect(response.body).to include "Description can&#39;t be blank"
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'リクエストが成功すること' do
      delete users_post_path(@post)
      expect(response).to be_truthy
    end

    it '記事が論理削除され、discaded_atに日付が入ること' do
      expect do
      delete users_post_path(@post)
      end.to change(Post, :count).by(-1)
      expect(Post.with_discarded.find(@post.id).discarded_at.strftime("%Y-%m-%d %H:%M:%S")).to eq(Time.now.strftime("%Y-%m-%d %H:%M:%S"))
    end

    it '記事の論理削除後に復元できること' do
      @post.discard
      expect(Post.with_discarded.find(@post.id).discarded_at.strftime("%Y-%m-%d %H:%M:%S")).to eq(Time.now.strftime("%Y-%m-%d %H:%M:%S"))
      @post.undiscard
      expect(Post.with_discarded.find(@post.id).discarded_at).to eq(nil)
    end

    it 'トップページにリダイレクトすること' do
      delete users_post_path(@post)
      expect(response).to redirect_to(root_path)
    end

    it 'userを削除した際に、投稿が論理削除されること' do
      User.find(1).destroy
      expect(Post.with_discarded.find(@post.id).discarded_at.to_s).to eq(Time.current.to_s)
    end
  end

  describe 'GET #index' do
    it 'リクエストが成功すること' do
      get users_posts_path
      expect(response.status).to eq 200
    end

    it '画像が表示されていること' do
      get users_posts_path
      expect(response.body).to include "text_image_300%C3%97300.png"
    end
  end
end