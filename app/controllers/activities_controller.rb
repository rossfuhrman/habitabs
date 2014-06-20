class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.where(user_id: current_user.id)
    @date_range = get_date_range
    @start_date_for_previous_link = get_start_date_for_previous_week_link @date_range
    @start_date_for_next_link = get_start_date_for_next_link @date_range
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

  private

    def get_date_range

      if params[:start_date]
        DateRange.new(params[:start_date].to_date)
      else
        DateRange.new
      end
    end

    def get_start_date_for_previous_week_link date_range
      date_range.previous_week_start_date
    end

    def get_start_date_for_next_link date_range
      date_range.next_week_start_date
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:title, :private, :polarity, :description, :user_id).merge(user_id: current_user.id)
    end
end
