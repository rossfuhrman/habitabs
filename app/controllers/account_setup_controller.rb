class AccountSetupController < Wicked::WizardController
  steps :add_good_habit, :add_bad_habit, :add_measured_habit

  def show
      case step
      when :add_good_habit
        @habit = Habit.new
      when :add_bad_habit
        @habit = Habit.new
      else
        @measured_habit = MeasuredHabit.new
      end
    render_wizard
  end

  def update

    if params[:habit] && params[:habit][:wizard_titles]

      case step
      when :add_good_habit
        the_polarity = Habit::POSITIVE
      when :add_bad_habit
        the_polarity = Habit::NEGATIVE
      else
        the_polarity = Habit::NEUTRAL
      end

      titles = params[:habit][:wizard_titles]
      titles.each do |new_title|
        habit = Habit.new
        habit.title = new_title
        habit.polarity = the_polarity
        habit.user = current_user
        habit.save
      end

    end

    if params[:measured_habit]
      measured_habit = MeasuredHabit.new
      measured_habit.title = params[:measured_habit][:title]
      measured_habit.polarity = params[:measured_habit][:polarity]
      measured_habit.description = params[:measured_habit][:description]
      measured_habit.measurement_type = params[:measured_habit][:measurement_type]
      measured_habit.user = current_user
      measured_habit.save
    end

    @habit = Habit.last
    render_wizard @habit
  end
end
