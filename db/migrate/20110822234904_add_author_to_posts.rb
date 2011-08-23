class AddAuthorToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer, :default => 1
  end
end
