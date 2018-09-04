class StatusError < StandardError
end

class InvalidUserError < StandardError
end

class Job < ActiveRecord::Base
  include LocationParser
  
  before_validation :default_date
  
  attr_accessible :title, :description, :category, :input_location, :complete_by
  attr_reader :complete_by_hash
  
  validates :title, :user, :location, :complete_by, presence: true
  validates :status, inclusion: { in: ["open", "awarded", "completed", "closed"], message: "is invalid" }
  
  belongs_to :user
  has_one :user_profile, through: :user, source: :profile
  has_many :bids, dependent: :destroy
  has_many :bidders, through: :bids, source: :bidder
  has_many :bidder_profiles, through: :bidders, source: :profile
  has_one :award, autosave: true, dependent: :destroy
  has_one :awardee, through: :award, source: :recipient
  has_one :awardee_profile, through: :awardee, source: :profile
  has_one :rating, autosave: true
    
  def formatted_date
    complete_by ? complete_by.strftime("%b %d, %Y") : "no date"
  end
  
  def default_date
    self.complete_by ||= Time.now + 1.month
  end
  
  def add_bid(bidder_id)
    if self.status != 'open'
      raise StatusError
    elsif self.bids.pluck("bidder_id").include?(bidder_id.to_i)
      raise InvalidUserError
    else
      self.bids.create!(bidder_id: bidder_id.to_i)
      Notification.create!(user_id: self.user_id, status: "unread", content: "Someone bid on your job, <a href=\"jobs/#{id}\">#{self.title}</a>!")
    end
  end
  
  def remove_bid(bid_id)
    if self.status != 'open'
      raise StatusError
    elsif !self.bids.pluck("id").include?(bid_id.to_i)
      raise StandardError
    else
      Bid.find(bid_id.to_i).destroy
    end
  end
  
  def grant_award(recipient_id)
    if self.status != 'open' || self.award != nil
      raise StatusError
    elsif !self.bids.pluck("bidder_id").include?(recipient_id.to_i)
      raise InvalidUserError
    else
      self.build_award(recipient_id: recipient_id.to_i)
      self.status = "awarded"
      self.save!
      Notification.create!(user_id: recipient_id, status: "unread", content: "You've been awarded a job, <a href=\"jobs/#{id}\">#{self.title}</a>!")
    end
  end
  
  def revoke_award
    if self.award == nil
      raise StatusError
    else      
      self.award.destroy
      self.status = "open"
      self.save!
    end
  end
  
  def complete
    if self.status == "awarded"
      self.status = "completed"
      r = self.build_rating(score: 0)
      r.rated = self.awardee
      self.save!
      Notification.create!(user_id: self.user_id, status: "unread", content: "Your job <a href=\"jobs/#{id}\">#{self.title}</a>, is complete! Please close it and rate the user who helped you!")
    else
      raise StatusError
    end
  end
  
  def close
    if self.status == "completed"
      self.status = "closed"
      self.save!
    else
      raise StatusError
    end
  end
    
end
