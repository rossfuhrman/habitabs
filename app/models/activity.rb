class Activity < ActiveRecord::Base
  validates_presence_of :title, :user
  belongs_to :user
end
