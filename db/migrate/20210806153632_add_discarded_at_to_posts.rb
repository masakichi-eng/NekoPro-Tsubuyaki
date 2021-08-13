class AddDiscardedAtToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :discarded_at, :datetime, comment: '論理削除した日時'
    add_index :posts, :discarded_at
  end
end
