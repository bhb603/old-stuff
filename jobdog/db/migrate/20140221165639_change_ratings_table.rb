class ChangeRatingsTable < ActiveRecord::Migration
  def up
    add_column :ratings, :completed, :boolean, null: false, default: false
    
  end

  def down
    remove_column :ratings, :completed
  end
end
