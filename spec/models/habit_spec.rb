require 'spec_helper'

describe Habit do
  describe "adding an habit" do
    it "is valid with a title" do
      user = FactoryGirl.create(:user)
      habit = Habit.new title: "an title", user: user
      expect(habit).to be_valid
    end
    it "is invaild without a title" do
      habit = Habit.new
      expect(habit).to have(1).errors_on(:title)
    end
    it "is valid with a user" do
    end
    it "is invalid without a user" do
      habit = Habit.new title: "an title"
      expect(habit).to have(1).errors_on(:user)
    end
  end
end
