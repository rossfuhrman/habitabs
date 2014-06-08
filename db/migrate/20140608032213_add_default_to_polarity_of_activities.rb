class AddDefaultToPolarityOfActivities < ActiveRecord::Migration
  def up
    change_column :activities, :polarity, :integer, default: 0
  end

  def down
    change_column :activities, :polarity, :integer, default: nil
  end
end
