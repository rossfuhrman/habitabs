class Activity < ActiveRecord::Base
  validates_presence_of :title, :user
  belongs_to :user
  has_many :marks , :dependent => :destroy
  def marks_on_date date
    marks.where(:mark_date => date).count
    #this should probably not return anything if the count is zero
    #if I make it return an empty string for 0,
    #then the javascript doesn't work and the page isn't updated
    #so I am doing that conversion in the js
  end
end
