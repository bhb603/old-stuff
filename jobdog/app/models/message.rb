class Message < ActiveRecord::Base
  attr_accessible :name, :email, :content
  
  validates :name, :email, :content, presence: true
end
