class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.date :mark_date
      t.integer :count
      t.references :activity

      t.timestamps
    end
  end
end
