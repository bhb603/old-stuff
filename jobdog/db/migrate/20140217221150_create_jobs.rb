class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description
      t.string :category
      t.string :location
      t.datetime :complete_by
      t.timestamps
    end
    
    add_index :jobs, :user_id
  end
end
