class AddDiscardedAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :discarded_at, :datetime, comment: '論理削除した日時'
    add_index :users, :discarded_at
  end
end
