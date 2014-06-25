require 'spec_helper'
describe MarksController do
  login_user
  let(:valid_attributes) { { mark_date: Date.today, habit_id: 1} }

  before(:each) do
      @habit = Habit.new :title => "hey"
      @habit.user = subject.current_user
      @habit.save
      #habit = FactoryGirl.create(:habit)
  end

  describe "POST create" do
    describe "with valid params" do
      #this fails - I think I'm building the params incorrectly, but it works in the view
      it "creates a new Mark" do
        expect {
          post :create, {:mark => valid_attributes}
        }.to change(Mark, :count).by(1)
      end

    end

  end
end
