class ChangePolarityFormatInActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :polarity
    add_column :activities, :polarity, :integer
  end
end
