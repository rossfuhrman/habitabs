class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /habits
  # GET /habits.json
  def index
    #
    #
    #
    #
    #this includes all of the marks
    #so after a year or two of marks 
    #it could become a problem :(
    @habits = current_user.habits.includes(:marks).order(:position)
    @measured_habits = MeasuredHabit.where(user_id: current_user.id).includes(:measurements).order(:position)
    @date_range = get_date_range
    @journal_entries = current_user.journals.where('date <= ?', @date_range.days.last.date).where('date >= ?', @date_range.days.first.date)
    @start_date_for_previous_link = get_start_date_for_previous_week_link @date_range
    @start_date_for_next_link = get_start_date_for_next_link @date_range
    get_mark_total_for_each_day
  end

  def get_mark_total_for_each_day 
    @date_range.days.each_with_index do |day, i|
      day.mark_total = @habits.map{|habit| habit.mark_sum_for day.date}.inject(0, :+)
    end
  end

  # GET /habits/1
  # GET /habits/1.json
  def show
    @date = params[:date] ? Date.parse(params[:date]) : Time.current.to_date
    @marks_by_date = @habit.marks.group_by(&:mark_date)
  end

  def list
    @habits = Habit.where(user_id: current_user.id).order(:position)
  end

  def sort
    params[:habit].each_with_index do |id, index|
      Habit.where(id: id).update_all({position: index+1})
    end
    render nothing: true
  end

  # GET /habits/new
  def new
    @habit = Habit.new
  end

  # GET /habits/1/edit
  def edit
  end

  # POST /habits
  # POST /habits.json
  def create
    measurement_type = if params[:extra]
                          params[:extra][:measurement_type]
                       else
                         "Marks"
                       end
    if measurement_type == "" || measurement_type == "Marks"
      @habit = Habit.new(habit_params)
    else
      @habit = MeasuredHabit.new(habit_params)
      @habit.measurement_type = measurement_type
    end

    respond_to do |format|
      if @habit.save
        format.html { redirect_to habits_url, notice: 'Habit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @habit }
      else
        format.html { render action: 'new' }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /habits/1
  # PATCH/PUT /habits/1.json
  def update
    respond_to do |format|
      if @habit.update(habit_params)
        format.html { redirect_to @habit, notice: 'Habit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habits/1
  # DELETE /habits/1.json
  def destroy
    @habit.destroy
    respond_to do |format|
      format.html { redirect_to habits_url }
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
    def set_habit
      @habit = current_user.habits.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def habit_params
      params.require(:habit).permit(:title, :private, :polarity, :description, :user_id).merge(user_id: current_user.id)
    end
end
