class Contact < ActiveRecord::Base
  attr_accessible :address, :email, :name, :phone_number
  belongs_to :user
  has_one :favorite, dependent: :destroy
  validates :address,:email,:name,:phone_number, presence: true

end
