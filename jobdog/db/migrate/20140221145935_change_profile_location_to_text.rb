class ChangeProfileLocationToText < ActiveRecord::Migration
  def up
    change_column :profiles, :location, :text
  end

  def down
    change_column :profiles, :location, :string
  end
end
