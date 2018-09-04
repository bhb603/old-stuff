class Profile < ActiveRecord::Base
  include LocationParser
  
  attr_accessible :first_name, :last_name, :input_location, :photo, :google_photo
  
  validates :user, :location, presence: true
  
  has_attached_file :photo, styles: { thumb: "200x200" },
    :default_url => "/assets/missing.png"
  validates_attachment :photo, content_type: { content_type: /\Aimage/ }, size: { in: 0..100.kilobytes }
  
  belongs_to :user, inverse_of: :profile
  
  def photo_url(format)
    if photo.exists?
      return photo.url(format)
    elsif google_photo
      return google_photo
    else
      return photo.url(format)
    end
  end
end
