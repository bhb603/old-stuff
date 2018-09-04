class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.text :content
      t.string :status
      t.timestamps
    end
    
    add_index :notifications, :user_id
  end
end
