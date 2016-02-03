require 'spec_helper'

describe MeasuredHabitsController do
  login_user
  before(:each) do
      @measured_habit = MeasuredHabit.new :title => "hey"
      @measured_habit.user = subject.current_user
      @measured_habit.save
  end
  describe "GET show" do
    it "assigns the requested measured habit as @measured_habit" do
      get :show, {:id => @measured_habit.to_param}
      assigns(:measured_habit).should eq(@measured_habit)
    end
		it "assigns today's date as @date when date param is not supplied" do
      get :show, {:id => @measured_habit.to_param}
      assigns(:date).should eq(Date.today)
    end
		it "assigns supplied date as @date when date param is supplied" do
			supplied_date = Date.today - 10.days
      get :show, {:id => @measured_habit.to_param, :date => supplied_date}
      assigns(:date).should eq(supplied_date)
    end

  end
  describe "GET edit" do
    it "assigns the requested measured habit as @measured_habit" do
      get :edit, {:id => @measured_habit.to_param}
      assigns(:measured_habit).should eq(@measured_habit)
    end
  end
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested measured habit" do
        MeasuredHabit.any_instance.should_receive(:update).with({ "title" => "MyString", "user_id" => 1 })
        put :update, {:id => @measured_habit.to_param, :measured_habit => { "title" => "MyString" }}
      end

      it "assigns the requested measured_habit as @measured_habit" do
        put :update, {:id => @measured_habit.to_param, :measured_habit => { "title" => "MyString" }}
        assigns(:measured_habit).should eq(@measured_habit)
      end

      it "redirects to the measured_habit" do
        put :update, {:id => @measured_habit.to_param, :measured_habit => { "title" => "MyString" }}
        response.should redirect_to(@measured_habit)
      end
    end

    describe "with invalid params" do
      it "assigns the measured_habit as @measured_habit" do
        # Trigger the behavior that occurs when invalid params are submitted
        MeasuredHabit.any_instance.stub(:save).and_return(false)
        put :update, {:id => @measured_habit.to_param, :measured_habit => { "title" => "invalid value" }}
        assigns(:measured_habit).should eq(@measured_habit)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        MeasuredHabit.any_instance.stub(:save).and_return(false)
        put :update, {:id => @measured_habit.to_param, :measured_habit => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end
  describe "DELETE destroy" do
    it "destroys the requested measured habit" do
      expect {
        delete :destroy, {:id => @measured_habit.to_param}
      }.to change(MeasuredHabit, :count).by(-1)
    end

    it "destroys the marks for the measured habit" do
      Measurement.create measurement_date: Time.current.to_date, measured_habit_id: @measured_habit.id, value: 1

      expect{
        delete :destroy, {:id => @measured_habit.to_param}
      }.to change(Measurement, :count).by(-1)
    end

    it "redirects to the habits list" do
      delete :destroy, {:id => @measured_habit.to_param}
      response.should redirect_to(habits_url)
    end
  end

end
