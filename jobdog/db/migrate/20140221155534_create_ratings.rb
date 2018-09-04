class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rater_id, null: false
      t.integer :rated_id, null: false
      t.integer :job_id, null: false
      t.integer :score, null: false
      t.text :comments
      t.timestamps
    end
    
    add_index :ratings, :rater_id
    add_index :ratings, :rated_id
    add_index :ratings, :job_id
  end
end
