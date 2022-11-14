class AddUserRefToScheduleBlock < ActiveRecord::Migration[7.0]
  def change
    add_reference :schedule_blocks, :user, null: true
  end
end
