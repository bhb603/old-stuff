class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :job_id, null: false
      t.integer :recipient_id, null: false
      t.timestamps
    end
    
    add_index :awards, :job_id, unique: true
    add_index :awards, :recipient_id
  end
end
