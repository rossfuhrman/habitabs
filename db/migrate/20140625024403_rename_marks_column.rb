class RenameMarksColumn < ActiveRecord::Migration
  def change
    rename_column(:marks, :activity_id, :habit_id)
  end
end
