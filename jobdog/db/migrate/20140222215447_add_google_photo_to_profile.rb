class AddGooglePhotoToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :google_photo, :string
  end
end
