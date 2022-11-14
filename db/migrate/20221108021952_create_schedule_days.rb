class CreateScheduleDays < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_days do |t|
      t.integer :week
      t.integer :begin_time
      t.integer :end_time
      t.integer :week_day
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
