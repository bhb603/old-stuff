class Award < ActiveRecord::Base
  attr_accessible :job_id, :recipient_id
  
  validates :job, :recipient, presence: true
  validates :job_id, uniqueness: true
  # validate :recipient_is_a_bidder
  
  belongs_to :job
  belongs_to :recipient, class_name: "User"
end
