class Notification < ActiveRecord::Base
  attr_accessible :user_id, :content, :status
  
  validates :user, :content, :status, presence: true
  validates :status, inclusion: { in: ["unread", "read"] }
  
  belongs_to :user
  
  def read
    self.status = "read"
    self.save
  end
    
  
end