require 'rails_helper'

RSpec.describe "Users::Posts", type: :request do

  before do
    @post = FactoryBot.create(:post)
  end

  it '記事投稿画面の表示に成功すること' do
    get new_users_post_path
    expect(response).to have_http_status(200)
  end

  it '記事投稿に成功したら記事が1件保存されること' do
    User.create(id: 1, name: 'test')
    expect{
      post users_post_path, params: { post: {description: 'test description', photo: Rack::Test::UploadedFile.new("public/images/text_image_300×300.png", "image/png")}}
    }.to change( Post, :count).by(1)
  end
end
