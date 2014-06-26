class AddPositionToHabits < ActiveRecord::Migration
  def change
    add_column :habits, :position, :integer
  end
end
