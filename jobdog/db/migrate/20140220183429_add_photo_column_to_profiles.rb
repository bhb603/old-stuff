class AddPhotoColumnToProfiles < ActiveRecord::Migration
  def up
    add_attachment :profiles, :photo
  end
  
  def down
    remove_attachment :profiles, :photo
  end
end
