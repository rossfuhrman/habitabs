class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.where(user_id: current_user.id)
    @dates = get_dates_to_display
    @dates_headers = get_dates_header @dates
    @end_date_for_previous_link = get_end_date_for_previous_week_link @dates
    @end_date_for_next_link = get_end_date_for_next_link @dates
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

    def get_dates_to_display
      amount_to_display = 2
      end_date = Date.today

      if params[:end_date]
        amount_to_display = 7
        end_date = params[:end_date].to_date
      end

      (0..amount_to_display - 1).each.collect{ |i| end_date - i }.reverse
    end

    def get_dates_header dates
      dates.each.map { |date| "#{date.strftime("%A")}<br />#{date}" }
    end

    def get_end_date_for_previous_week_link dates
      if dates.count == 2
        Date.today
      else
        dates.last.to_date - 7
      end
    end

    def get_end_date_for_next_link dates
      if dates.last == Date.today
        nil
      else
        dates.last + 7
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:title, :private, :polarity, :user_id).merge(user_id: current_user.id)
    end
end
