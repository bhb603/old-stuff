class NoUserError < StandardError
end

class WrongPasswordError < StandardError
end

class User < ActiveRecord::Base
  attr_accessible :email, :password, :uid, :provider
  attr_reader :password
  
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  validates :password, length: { minimum: 4, allow_nil: true }
  validate :password_digest_cannot_be_blank
  validates :uid, uniqueness: { scope: :provider, allow_nil: true }
  
  has_one :profile, dependent: :destroy, inverse_of: :user, autosave: true
  has_many :jobs, dependent: :destroy
  has_many :bids, class_name: "Bid", foreign_key: :bidder_id, dependent: :destroy
  has_many :bidded_jobs, through: :bids, source: :job
  has_many :awards, foreign_key: :recipient_id
  has_many :awarded_jobs, through: :awards, source: :job
  has_many :job_ratings, through: :jobs, source: :rating
  has_many :ratings, foreign_key: :rated_id
  has_many :notifications, dependent: :destroy

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    if user.nil?
      raise NoUserError, "No users with that email"
    elsif user.is_password?(password)
      return user
    else
      raise WrongPasswordError, "Incorrect password"
    end
  end
  
  def alias
    if self.profile.first_name && !self.profile.first_name.empty? && self.profile.last_name && !self.profile.last_name.empty?
      "#{self.profile.first_name.capitalize}  #{self.profile.last_name[0].capitalize}."
    elsif self.profile.last_name && !self.profile.last_name.empty?
      "#{self.profile.last_name.capitalize}"
    elsif self.profile.first_name && !self.profile.first_name.empty?
      "#{self.profile.first_name.capitalize}"
    else
      "#{self.email}"
    end
  end
  
  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end
  
  def password_digest_cannot_be_blank
    errors.add(:password, 'cannot be blank!') if password_digest.nil?
  end
  
  def is_password?(secret)
    BCrypt::Password.new(password_digest).is_password?(secret)
  end
  
end
