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
    describe "polarity" do
      describe "polarity_class" do
        it "should return 'neutral' for a neutral habit" do
          user = FactoryGirl.create(:user)
          neutral_habit = Habit.create title: "an title", user: user, polarity: Habit::NEUTRAL
          expect(neutral_habit.polarity_class).to eq("neutral")
        end
        it "should return 'positive' for a positive habit" do
          user = FactoryGirl.create(:user)
          positive_habit = Habit.create title: "an title", user: user, polarity: Habit::POSITIVE
          expect(positive_habit.polarity_class).to eq("positive")
        end
        it "should return 'negative' for a negative habit" do
          user = FactoryGirl.create(:user)
          negative_habit = Habit.create title: "an title", user: user, polarity: Habit::NEGATIVE
          expect(negative_habit.polarity_class).to eq("negative")
        end
      end
    end
    describe "marks" do
      describe "marks_on_date" do
        it "should return an empty string for no marks on the date" do
          user = FactoryGirl.create(:user)
          neutral_habit = Habit.create title: "an title", user: user, polarity: Habit::NEUTRAL
          expect(neutral_habit.marks_on_date Date.today).to eq("")
          Mark.create(mark_date: Date.new(2000,1,1), habit: neutral_habit)
          expect(neutral_habit.marks_on_date Date.today).to eq("")
        end
        it "should return the count for marks on the date" do
          user = FactoryGirl.create(:user)
          neutral_habit = Habit.create title: "an title", user: user, polarity: Habit::NEUTRAL
          Mark.create(mark_date: Date.today, habit: neutral_habit)
          expect(neutral_habit.marks_on_date Date.today).to eq(1)
        end
        it "should return the count as a positive number for a negative habit with  marks on the date" do
          user = FactoryGirl.create(:user)
          negative_habit = Habit.create title: "an title", user: user, polarity: Habit::NEGATIVE
          Mark.create(mark_date: Date.today, habit: negative_habit)
          expect(negative_habit.marks_on_date Date.today).to eq(1)
        end
      end

      describe "mark_total" do
        it "should return an empty string for no marks on the date" do
          user = FactoryGirl.create(:user)
          neutral_habit = Habit.create title: "an title", user: user, polarity: Habit::NEUTRAL
          expect(neutral_habit.mark_total Date.today).to eq("")
          Mark.create(mark_date: Date.new(2000,1,1), habit: neutral_habit)
          expect(neutral_habit.mark_total Date.today).to eq("")
        end
        it "should return the count for marks on the date" do
          user = FactoryGirl.create(:user)
          neutral_habit = Habit.create title: "an title", user: user, polarity: Habit::NEUTRAL
          Mark.create(mark_date: Date.today, habit: neutral_habit)
          expect(neutral_habit.mark_total Date.today).to eq(1)
        end
        it "should return the count as a positive number for a negative habit with  marks on the date" do
          user = FactoryGirl.create(:user)
          negative_habit = Habit.create title: "an title", user: user, polarity: Habit::NEGATIVE
          Mark.create(mark_date: Date.today, habit: negative_habit)
          expect(negative_habit.mark_total Date.today).to eq(1)
        end
      end

      describe "mark_value" do
        it "should return 0 for neutral habits" do
          user = FactoryGirl.create(:user)
          neutral_habit = Habit.create title: "an title", user: user, polarity: Habit::NEUTRAL
          expect(neutral_habit.mark_value 3).to eq(0)
        end
        it "should return 0 for positive habits with no marks" do
          user = FactoryGirl.create(:user)
          positive_habit = Habit.create title: "an title", user: user, polarity: Habit::POSITIVE
          expect(positive_habit.mark_value 0).to eq(0)
        end
        it "should return a positive integer for positive habits with marks" do
          user = FactoryGirl.create(:user)
          positive_habit = Habit.create title: "an title", user: user, polarity: Habit::POSITIVE
          expect(positive_habit.mark_value 2).to eq(2)
        end
        it "should return 0 for negative habits with no marks" do
          user = FactoryGirl.create(:user)
          negative_habit = Habit.create title: "an title", user: user, polarity: Habit::NEGATIVE
          expect(negative_habit.mark_value 0).to eq(0)
        end
        it "should return a positive integer for positive habits with marks" do
          user = FactoryGirl.create(:user)
          negative_habit = Habit.create title: "an title", user: user, polarity: Habit::NEGATIVE
          expect(negative_habit.mark_value 2).to eq(-2)
        end
      end
      describe "mark_sum_for a date" do
        it "should return 0 for neutral habits" do
          user = FactoryGirl.create(:user)
          neutral_habit = Habit.create title: "an title", user: user, polarity: Habit::NEUTRAL
          Mark.create(mark_date: Date.today, habit: neutral_habit)
          Mark.create(mark_date: Date.today, habit: neutral_habit)
          expect(neutral_habit.mark_sum_for Date.today).to eq(0)
        end
        it "should return 0 for positive habits with no marks" do
          user = FactoryGirl.create(:user)
          positive_habit = Habit.create title: "an title", user: user, polarity: Habit::POSITIVE
          expect(positive_habit.mark_sum_for Date.today).to eq(0)
        end
        it "should return a positive integer for positive habits with marks" do
          user = FactoryGirl.create(:user)
          positive_habit = Habit.create title: "an title", user: user, polarity: 1
          Mark.create(mark_date: Date.today, habit: positive_habit)
          Mark.create(mark_date: Date.today, habit: positive_habit)
          expect(positive_habit.mark_sum_for Date.today).to eq(2)
        end
        it "should return 0 for negative habits with no marks" do
          user = FactoryGirl.create(:user)
          negative_habit = Habit.create title: "an title", user: user, polarity: Habit::NEGATIVE
          expect(negative_habit.mark_sum_for Date.today).to eq(0)
        end
        it "should return a positive integer for positive habits with marks" do
          user = FactoryGirl.create(:user)
          negative_habit = Habit.create title: "an title", user: user, polarity: Habit::NEGATIVE
          Mark.create(mark_date: Date.today, habit: negative_habit)
          Mark.create(mark_date: Date.today, habit: negative_habit)
          Mark.create(mark_date: Date.today - 1, habit: negative_habit) #different date
          expect(negative_habit.mark_sum_for Date.today).to eq(-2)
        end
      end
    end
  end
end
