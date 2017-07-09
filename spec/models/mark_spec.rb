require 'spec_helper'

describe Mark do
  describe "adding a mark" do
    it "is valid with todays date" do
      habit = Habit.create
      mark = Mark.new( habit_id: habit.id,
                      mark_date: Date.today)
      expect(mark).to be_valid

    end
    it "is valid with a previous date" do
      habit = Habit.create
      mark = Mark.new( habit_id: habit.id,
                      mark_date: Date.today - 1)
      expect(mark).to be_valid

    end

    it "is invalid with a date in the future" do
      habit = Habit.create
      mark = Mark.new( habit_id: habit.id,
                      mark_date: Date.today + 1)
      expect(mark).to have(1).errors_on(:mark_date)
    end
    it "knows what habit it belongs to" do
      habit = Habit.new :title => "hey"
      habit.user = FactoryGirl.create(:user)
      habit.save!
      mark = Mark.create( habit_id: habit.id,
                      mark_date: Date.today + 1)
      expect(mark.habit).to eq(habit)
    end
  end
end
