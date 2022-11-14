class CreateScheduleBlocksUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_blocks_users, id: false do |t|
      t.integer :schedule_block_id
      t.integer :user_id
    end

    add_index :schedule_blocks_users, :schedule_block_id
    add_index :schedule_blocks_users, :user_id
  end
end
