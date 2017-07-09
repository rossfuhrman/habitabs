require 'spec_helper'
describe MarksController do
  login_user
  let(:valid_attributes) { { mark_date: Date.today, habit_id: 1} }

  before(:each) do
      @habit = Habit.new :title => "hey"
      @habit.user = subject.current_user
      @habit.save
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Mark" do
        expect {
          post :create, {:mark => valid_attributes}
        }.to change(Mark, :count).by(1)
      end
    end

    describe "with valid params for another user" do
      it "raises error when trying to add mark for someone elses habit " do
        other_users_habit = FactoryGirl.create(:other_users_habit)
        expect {
          post :create, {:mark => { mark_date: Date.today, habit_id: other_users_habit.id } }
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end

  describe "remove a mark" do
    before(:each) do
      @habit.marks.create({ mark_date: Date.today, habit_id: @habit.id})
    end

    describe "with valid params" do
      it "removes a Mark" do
        expect {
          post :remove, {:mark => valid_attributes, format: :json }
        }.to change(Mark, :count).by(-1)
      end
    end

    describe "with valid params for another user" do
      it "raises error when trying to remove mark for someone elses habit " do
        other_users_habit = FactoryGirl.create(:other_users_habit)
        expect {
          post :remove, {:mark => { mark_date: Date.today, habit_id: other_users_habit.id }, format: :json}
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

end
