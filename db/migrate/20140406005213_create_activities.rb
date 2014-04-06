class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.boolean :private, default: true
      t.string :polarity

      t.timestamps
    end
  end
end
