class AddLatLongToJobsAndUsers < ActiveRecord::Migration
  def change
    add_column :jobs, :latitude, :float
    add_column :jobs, :longitude, :float
    add_column :profiles, :latitude, :float
    add_column :profiles, :longitude, :float
  end
end
