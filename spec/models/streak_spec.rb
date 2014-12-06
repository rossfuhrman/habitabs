require 'spec_helper'

describe Streak do
  describe "habit with no marks" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
    end
    it "has no streak represented as empty string" do
      expect(Streak.new(@positive_habit).streak_duration).to eq("")
    end
    it "has a status of broken" do
      expect(Streak.new(@positive_habit).status).to eq(Streak::BROKEN)
    end
  end
  describe "habit with a mark yesterday, but not today" do
    describe "with one mark" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
        Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
      end
      it "has a streak of 1" do
        expect(Streak.new(@positive_habit).streak_duration).to eq(1)
      end
      it "has a status of yesterday" do
        expect(Streak.new(@positive_habit).status).to eq(Streak::YESTERDAY)
      end
    end
    describe "and a mark the day before yesterday" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
        Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
        Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
      end
      it "has a streak of 2" do
        expect(Streak.new(@positive_habit).streak_duration).to eq(2)
      end
      it "has a status of yesterday" do
        expect(Streak.new(@positive_habit).status).to eq(Streak::YESTERDAY)
      end
    end
  end
  describe "habit with a mark today" do
    describe "with one mark" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
        Mark.create(mark_date: Date.today, habit: @positive_habit)
      end
      it "has a streak of 1" do
        expect(Streak.new(@positive_habit).streak_duration).to eq(1)
      end
      it "has a status of today" do
        expect(Streak.new(@positive_habit).status).to eq(Streak::TODAY)
      end
    end
    describe "and a mark yesterday" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
        Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
        Mark.create(mark_date: Date.today, habit: @positive_habit)
      end
      it "has a streak of 2" do
        expect(Streak.new(@positive_habit).streak_duration).to eq(2)
      end
      it "has a status of today" do
        expect(Streak.new(@positive_habit).status).to eq(Streak::TODAY)
      end
    end
  end
  describe "habit with non-consecutive marks" do
    describe "with most recent mark yesterday" do
      it "only counts consecutive days from yesterday back" do
        @user = FactoryGirl.create(:user)
        @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
        Mark.create(mark_date: Date.today - 99, habit: @positive_habit)
        Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
        Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
        expect(Streak.new(@positive_habit).streak_duration).to eq(2)
        expect(Streak.new(@positive_habit).status).to eq(Streak::YESTERDAY)
      end
    end
    describe "with most recent mark today" do
      it "only counts consecutive days from today back" do
        @user = FactoryGirl.create(:user)
        @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
        Mark.create(mark_date: Date.today - 99, habit: @positive_habit)
        Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
        Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
        Mark.create(mark_date: Date.today, habit: @positive_habit)
        expect(Streak.new(@positive_habit).streak_duration).to eq(3)
        expect(Streak.new(@positive_habit).status).to eq(Streak::TODAY)
      end
    end
  end
  describe "habit with marks" do
    describe "but no marks yesterday or today" do
      it "has a broken streak" do
        @user = FactoryGirl.create(:user)
        @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
        Mark.create(mark_date: Date.today - 99, habit: @positive_habit)
        expect(Streak.new(@positive_habit).streak_duration).to eq("")
        expect(Streak.new(@positive_habit).status).to eq(Streak::BROKEN)
      end
    end
    describe "multiple marks on one day" do
      describe "and most recent is today" do
        it "only increments by one for that day" do
          @user = FactoryGirl.create(:user)
          @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
          Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
          Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
          Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
          Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
          Mark.create(mark_date: Date.today, habit: @positive_habit)
          Mark.create(mark_date: Date.today, habit: @positive_habit)
          expect(Streak.new(@positive_habit).streak_duration).to eq(3)
          expect(Streak.new(@positive_habit).status).to eq(Streak::TODAY)
        end
      end
      describe "and most recent is yesterday" do
        it "only increments by one for that day" do
          @user = FactoryGirl.create(:user)
          @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
          Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
          Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
          Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
          Mark.create(mark_date: Date.today - 1, habit: @positive_habit)
          expect(Streak.new(@positive_habit).streak_duration).to eq(2)
          expect(Streak.new(@positive_habit).status).to eq(Streak::YESTERDAY)
        end
      end
      describe "and most recent is old" do
        it "has no streak" do
          @user = FactoryGirl.create(:user)
          @positive_habit = Habit.create title: "an title", user: @user, polarity: Habit::POSITIVE
          Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
          Mark.create(mark_date: Date.today - 2, habit: @positive_habit)
          expect(Streak.new(@positive_habit).streak_duration).to eq("")
          expect(Streak.new(@positive_habit).status).to eq(Streak::BROKEN)
        end
      end
    end
  end
end
