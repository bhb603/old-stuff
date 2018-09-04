class ChangeJobLocationColumn < ActiveRecord::Migration
  def up
    change_column :jobs, :location, :text
  end

  def down
    change_column :jobs, :location, :string
  end
end
