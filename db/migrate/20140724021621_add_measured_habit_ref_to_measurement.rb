class AddMeasuredHabitRefToMeasurement < ActiveRecord::Migration
  def change
    add_reference :measurements, :measured_habit, index: true
  end
end
