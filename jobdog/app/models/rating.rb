class Rating < ActiveRecord::Base
  attr_accessible :score, :comments
  
  validates :rater, :rated, :job, :score, presence: true
  validates :job_id, uniqueness: true
  
  belongs_to :rated, class_name: "User"
  belongs_to :job
  has_one :rater, through: :job, source: :user
end
