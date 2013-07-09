class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :token
  has_many :contacts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
