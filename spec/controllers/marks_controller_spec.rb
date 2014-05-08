require 'spec_helper'
describe MarksController do
  login_user
  let(:valid_attributes) { { mark_date: Date.today, activity_id: 1} }

  before(:each) do
      @activity = Activity.new :title => "hey"
      @activity.user = subject.current_user
      @activity.save
      #activity = FactoryGirl.create(:activity)
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
