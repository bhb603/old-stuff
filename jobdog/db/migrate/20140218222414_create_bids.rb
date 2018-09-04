class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :bidder_id, null: false
      t.integer :job_id, null: false
      t.timestamps
    end
    
    add_index :bids, :bidder_id
    add_index :bids, :job_id
    add_index :bids, [:bidder_id, :job_id], unique: true
  end
end
