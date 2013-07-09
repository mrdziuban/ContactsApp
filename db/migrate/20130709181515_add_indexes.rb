class AddIndexes < ActiveRecord::Migration
  def change
    add_index :contacts, :user_id
    add_index :favorites, :contact_id
    add_index :favorites, :user_id
  end
end
