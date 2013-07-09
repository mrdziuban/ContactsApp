class Contact < ActiveRecord::Base
  attr_accessible :address, :email, :name, :phone_number, :user_id
  belongs_to :user
  has_one :favorite
  validates :address, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true
end
