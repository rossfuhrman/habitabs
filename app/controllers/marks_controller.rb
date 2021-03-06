class MarksController < ApplicationController
  def create
    @mark = current_user.habits.find(mark_params[:habit_id]).marks.new(mark_params)
    respond_to do |format|
      if @mark.save
        format.html { redirect_to @mark, notice: 'Mark was successfully created.' }
        habits = Habit.where(user_id: current_user.id).includes(:marks)
        mark_total_for_day = habits.map{|habit| habit.mark_sum_for mark_params[:mark_date].to_date}.inject(0, :+)
        format.json { render :json => {:habit_mark_count => @mark.habit.marks_on_date(mark_params[:mark_date]), :day_total => mark_total_for_day, :streak_duration => @mark.habit.streak.streak_duration  } }
      else
        format.html { render action: 'new' }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    habit_id = params[:mark][:habit_id] 
    mark_date = params[:mark][:mark_date]
    if mark = current_user.habits.find(habit_id).marks.where(:mark_date => mark_date).first
      mark.delete
    end

    habit = current_user.habits.find params[:mark][:habit_id]
    mark_count = habit.marks_on_date(params[:mark][:mark_date])

    respond_to do |format|
        habits = current_user.habits.includes(:marks)
        mark_total_for_day = habits.map{|habit| habit.mark_sum_for params[:mark][:mark_date].to_date}.inject(0, :+)
        format.json {
          render :json => {:habit_mark_count => mark_count, :day_total => mark_total_for_day, :streak_duration => habit.streak.streak_duration }
        }
    end
  end

  private

    def mark_params
      params.require(:mark).permit(:habit_id, :mark_date, :count)
    end
end
