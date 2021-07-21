require 'rails_helper'

RSpec.describe "Users::Posts", type: :request do
  it '記事投稿画面の表示に成功すること' do
    get new_users_post_path
    expect(response).to have_http_status(200)
  end
  it '記事投稿に成功したら記事が1件保存されること' do
    puts post users_post_path, params: { post: { description: 'sample description'} }
    expect{
      post users_post_path, params: { post: { description: 'sample description'} }
    }.to change( Post, :count).by(1)
  end
end
