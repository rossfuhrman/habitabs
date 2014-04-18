require 'spec_helper'

describe Mark do
  describe "adding a mark" do
    it "is valid with todays date" do
      activity = Activity.create
      mark = Mark.new( activity_id: activity.id,
                      mark_date: Date.today)
      expect(mark).to be_valid

    end
    it "is valid with a previous date" do
      activity = Activity.create
      mark = Mark.new( activity_id: activity.id,
                      mark_date: Date.today - 1)
      expect(mark).to be_valid

    end

    it "is invalid with a date in the future" do
      activity = Activity.create
      mark = Mark.new( activity_id: activity.id,
                      mark_date: Date.today + 1)
      expect(mark).to have(1).errors_on(:mark_date)
    end
  end
end
