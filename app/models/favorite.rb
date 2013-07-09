class Favorite < ActiveRecord::Base
  attr_accessible :contact_id, :user_id
  belongs_to :user
  belongs_to :contact
end
