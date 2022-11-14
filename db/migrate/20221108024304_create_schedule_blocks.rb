class CreateScheduleBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_blocks do |t|
      t.integer :hour
      t.references :schedule_day, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
