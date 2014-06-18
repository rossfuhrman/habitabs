require 'spec_helper'

describe DateRange do
  it "should set the start date to the sunday of the week the date falls in" do
    sunday = Time.new(2014,06,15).to_date
    [ 
      [Time.new(2014,06,15).to_date, sunday],
      [Time.new(2014,06,16).to_date, sunday],
      [Time.new(2014,06,17).to_date, sunday],
      [Time.new(2014,06,18).to_date, sunday],
      [Time.new(2014,06,19).to_date, sunday],
      [Time.new(2014,06,20).to_date, sunday],
      [Time.new(2014,06,21).to_date, sunday]
    ].each do |supplied_date, sunday_date|
      date_range = DateRange.new(supplied_date)
      expect(date_range.start_date).to eq(sunday_date)

    end
  end
  it "should get the sunday of the week of the current day when no date is supplied" do
      sunday_date = Time.current.to_date - Time.current.to_date.wday
      date_range = DateRange.new()
      expect(date_range.start_date).to eq(sunday_date)
  end

  it "should have an array of DateHelper objects in the days method" do
    date_range = DateRange.new()
    expect(date_range.days.class).to eq(Array)
    expect(date_range.days.first.class).to eq(DateHelper)

    date_range = DateRange.new(Date.today - 7)
    expect(date_range.days.class).to eq(Array)
    expect(date_range.days.first.class).to eq(DateHelper)
  end
  describe "days" do
    it "should have 7 values" do
      date_range = DateRange.new()
      expect(date_range.days.count).to eq(7)

      date_range = DateRange.new(Date.today - 7)
      expect(date_range.days.count).to eq(7)
    end
    it "should handle timezones appropriately" do
      #I'm not sure how to handle this atm
      #(or test for it)
      #since in the controller code #I was doing Time.current.to_date
      #so I have that in the date_range.rb file
    end
  end
  describe "previous_week_start_date" do
    describe "current week" do
      it "should get the first day of the previous week" do
        date_range = DateRange.new
        expect(date_range.previous_week_start_date).to eq(date_range.days[0].date - 7)
      end
    end
    describe "one week prior" do
      it "should get the first day of the previous week" do
        date_range = DateRange.new(Time.current.to_date - 7)
        expect(date_range.previous_week_start_date).to eq(date_range.days[0].date - 7)
      end
    end
  end
  describe "next_week_start_date" do
    describe "current week" do
      it "should return nil" do
        date_range = DateRange.new
        expect(date_range.next_week_start_date).to eq(nil)
      end
    end
    describe "one week prior" do
      it "should return the start of the next week" do
        date_range = DateRange.new(Time.current.to_date - 7)
        expect(date_range.next_week_start_date).to eq(date_range.days[0].date + 7)
      end
    end
  end
end
