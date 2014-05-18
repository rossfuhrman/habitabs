class MarkValidator < ActiveModel::Validator
  def validate(record)
    if record.mark_date > Date.today
      record.errors[:mark_date] << "Mark date cannot be in the future"
    end
  end
end

class Mark < ActiveRecord::Base
  includes ActiveModel::Validations
  validates_with MarkValidator
  belongs_to :activity 
end
