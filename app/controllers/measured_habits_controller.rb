class MeasuredHabitsController < ApplicationController
  before_action :set_measured_habit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def edit
  end

  def update
    respond_to do |format|
      if @measured_habit.update(measured_habit_params)
        format.html { redirect_to @measured_habit, notice: 'Habit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @measured_habit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @measured_habit.destroy
    respond_to do |format|
      format.html { redirect_to habits_url }
      format.json { head :no_content }
    end
  end

  private

    def set_measured_habit
      @measured_habit = MeasuredHabit.find(params[:id])
    end

    def measured_habit_params
      params.require(:measured_habit).permit(:title, :private, :polarity, :description, :user_id, :measurement_type).merge(user_id: current_user.id)
    end
end
