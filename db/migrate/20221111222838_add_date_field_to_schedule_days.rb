class AddDateFieldToScheduleDays < ActiveRecord::Migration[7.0]
  def change
    add_column :schedule_days, :date, :date
  end
end
