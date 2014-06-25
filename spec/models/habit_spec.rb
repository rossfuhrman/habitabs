require 'spec_helper'

describe Activity do
  describe "adding an activity" do
    it "is valid with a title" do
      user = FactoryGirl.create(:user)
      activity = Activity.new title: "an title", user: user
      expect(activity).to be_valid
    end
    it "is invaild without a title" do
      activity = Activity.new
      expect(activity).to have(1).errors_on(:title)
    end
    it "is valid with a user" do
    end
    it "is invalid without a user" do
      activity = Activity.new title: "an title"
      expect(activity).to have(1).errors_on(:user)
    end
  end
end
