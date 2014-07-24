class CreateMeasuredHabits < ActiveRecord::Migration
  def change
    create_table :measured_habits do |t|
      t.string :title
      t.boolean :private
      t.integer :polarity, default: 0
      t.text :description
      t.integer :position
      t.string :measurement_type

      t.timestamps

    end

    add_reference :measured_habits, :user, index: true
  end
end
