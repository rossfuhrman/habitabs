class MeasurementsController < ApplicationController
  def create
    @measurement = Measurement.where(measured_habit_id: measurement_params[:measured_habit_id],
                                     measurement_date: measurement_params[:measurement_date]).first_or_initialize
    @measurement.value = measurement_params[:value]

    respond_to do |format|
      if @measurement.save
        format.html { redirect_to @measurement, notice: 'Measurement was successfully created.' }
        format.json { render :json => {:value => @measurement.value.to_f} }
      else
        format.html { render action: 'new' }
        format.json { render json: @measurement.errors, status: :unprocessable_entity }
      end
    end
  end
  private

    def measurement_params
      params.require(:measurement).permit(:measured_habit_id, :measurement_date, :value)
    end
end
