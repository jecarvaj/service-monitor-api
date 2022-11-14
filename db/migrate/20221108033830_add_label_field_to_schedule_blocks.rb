class AddLabelFieldToScheduleBlocks < ActiveRecord::Migration[7.0]
  def change
    add_column :schedule_blocks, :label, :string
  end
end
