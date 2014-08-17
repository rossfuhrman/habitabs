require 'spec_helper'
describe DateHelper do
  describe "a date" do
    it "knows if it is the current date" do
      date_helper = DateHelper.new(Date.today)
      expect(date_helper.is_today?).to be_true
    end
    it "knows if it is in the future" do
      date_helper = DateHelper.new(Date.today + 1)
      expect(date_helper.in_the_future?).to be_true
    end
    it "knows what its display class for the view is" do
      date_helper_today = DateHelper.new(Date.today)
      expect(date_helper_today.display_class).to eq("today")

      date_helper_future = DateHelper.new(Date.today + 1)
      expect(date_helper_future.display_class).to eq("future")

      date_helper_past = DateHelper.new(Date.today - 1)
      expect(date_helper_past.display_class).to eq("past")
    end
    it "knows what day of the week it is" do
      date_helper = DateHelper.new(Date.new(2014, 6, 12))
      expect(date_helper.day_of_week).to eq("Thursday")
    end
    it "knows the abbreviated day of the week" do
      date_helper = DateHelper.new(Date.new(2014, 6, 12))
      expect(date_helper.day_of_week_abbreviated).to eq("Thu")
    end
    it "returns date in mm/dd/yy format" do
      date_helper = DateHelper.new(Date.new(2014, 6, 12))
      expect(date_helper.to_date).to eq("6/12/14")
    end
  end
end
