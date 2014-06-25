class RenameActivitiesToHabits < ActiveRecord::Migration
  def change
    rename_table(:activities, :habits)
  end
end
