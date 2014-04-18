require 'spec_helper'
describe MarksController do
  let(:valid_activity_attributes) { { "title" => "MyString", "private" => false, "polarity" => "good"} }
  let(:valid_attributes) { { mark_date: Date.today, activity_id: 1} }
  let(:valid_session) { {} }

  describe "POST create" do
    describe "with valid params" do
      #this fails - I think I'm building the params incorrectly, but it works in the view
      it "creates a new Mark" do
        activity = Activity.create! valid_activity_attributes
        expect {
          post :create, {:mark => valid_attributes}, valid_session
        }.to change(Mark, :count).by(1)
      end

    end

  end
end
