require 'spec_helper'

describe MeasuredHabit do
	describe "#measurement_options" do
		it "should not include 'Marks' option" do
			expect(MeasuredHabit.measurement_options.include?("Marks")).to be_true
		end
	end
  describe "#measurement_options_for_account_setup" do
		it "should not include 'Marks' option" do
			expect(MeasuredHabit.measurement_options_for_account_setup.include?("Marks")).to be_false
		end
	end
	describe "#get_measurement_value" do
		describe "value exists on supplied date" do
			it "should return the first value for the date" do
				measured_habit = FactoryGirl.create(:measured_habit)
				measurement = FactoryGirl.create(:measurement)
				measured_habit.measurements << measurement
				expect(measured_habit.get_measurement_value(Date.today)).to eq(9.99)
			end
		end
		describe "value does not exist on supplied date" do
			it "should return an empty string" do
				measured_habit = MeasuredHabit.new
				expect(measured_habit.get_measurement_value(Date.today)).to eq("")
			end
		end
	end
	describe "polarity_class" do
		it "should return 'positive' for a positive habit" do
			measured_habit = FactoryGirl.create(:measured_habit, polarity: POSITIVE)
			expect(measured_habit.polarity_class).to eq("positive")
		end
	end
end
