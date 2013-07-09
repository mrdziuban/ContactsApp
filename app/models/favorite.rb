class Favorite < ActiveRecord::Base
  attr_accessible :contact_id
  belongs_to :user
  belongs_to :contact
end
