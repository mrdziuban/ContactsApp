class Contact < ActiveRecord::Base
  attr_accessible :address, :email, :name, :phone_number
end
