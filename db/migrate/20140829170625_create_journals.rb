class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.text :entry
      t.date :date

      t.timestamps
    end
  end
end
