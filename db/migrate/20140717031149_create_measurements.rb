class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.date :measurement_date
      t.decimal :value, :decimal, precision: 10, scale: 4

      t.timestamps
    end
  end
end
