class MarksController < ApplicationController
  def create
    @mark = Mark.new(mark_params)
    respond_to do |format|
      if @mark.save
        format.html { redirect_to @mark, notice: 'Mark was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @mark }
        format.json { render :json => @mark.activity.marks_on_date(mark_params[:mark_date]) }
      else
        format.html { render action: 'new' }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def mark_params
      params.require(:mark).permit(:activity_id, :mark_date, :count)
    end
end
