class MarksController < ApplicationController
  def create
    @mark = Mark.new(mark_params)
    respond_to do |format|
      if @mark.save
        format.html { redirect_to @mark, notice: 'Mark was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @mark }
        format.json { render :json => @mark.habit.marks_on_date(mark_params[:mark_date]) }
      else
        format.html { render action: 'new' }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    habit_id = params[:mark][:habit_id] 
    mark_date = params[:mark][:mark_date]
    if mark = Mark.where(:habit_id => habit_id).where(:mark_date => mark_date).first
      mark.delete
    end

    habit = Habit.find params[:mark][:habit_id]
    mark_count = habit.marks_on_date(params[:mark][:mark_date])

    respond_to do |format|
      #if @mark.save
        #format.html { redirect_to @mark, notice: 'Mark was successfully created.' }
        format.json { render :json => mark_count }
      #else
      #  format.html { render action: 'new' }
      #  format.json { render json: @mark.errors, status: :unprocessable_entity }
      #end
    end
  end

  private

    def mark_params
      params.require(:mark).permit(:habit_id, :mark_date, :count)
    end
end
