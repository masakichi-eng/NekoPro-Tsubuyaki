class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts, comment: '投稿関連' do |t|
      t.integer :user_id, comment: 'ユーザーとの紐付け'
      t.text :description, comment: '投稿内容'
      t.timestamps
    end
  end
end
