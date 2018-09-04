class Bid < ActiveRecord::Base
  attr_accessible :bidder_id, :job_id
  
  validates :bidder, :job, presence: true
  validate :job_open
  validate :already_bid
  
  belongs_to :bidder, class_name: "User", foreign_key: :bidder_id
  belongs_to :job
  
  def already_bid
    bids = Bid.where("job_id = ? AND bidder_id = ?", job_id, bidder_id)
    unless bids.empty?
      errors.add(:you, "have already bid this job")
    end
  end
  
  def job_open 
    unless self.job.status == 'open'
      errors.add(:job, "is closed")
    end
  end
end
