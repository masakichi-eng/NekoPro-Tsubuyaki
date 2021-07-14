class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, comment: 'ユーザー関連' do |t|
      t.string :name, comment: 'ユーザー名'
      t.timestamps
    end
  end
end
