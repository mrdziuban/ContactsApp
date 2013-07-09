class User < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :contacts
  has_many :favorites
  validates :name, presence: true
  validates :email, presence: true
end
