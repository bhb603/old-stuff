class RemoveRaterIdFromRating < ActiveRecord::Migration
  def up
    remove_column :ratings, :rater_id
  end

  def down
    add_column :ratings, :rater_id, :integer, null: false
  end
end
