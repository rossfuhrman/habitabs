class Activity < ActiveRecord::Base
  validates_presence_of :title, :user
  belongs_to :user
  has_many :marks , :dependent => :destroy
  def marks_on_date date
    marks.where(:mark_date => date).count
  end
end
