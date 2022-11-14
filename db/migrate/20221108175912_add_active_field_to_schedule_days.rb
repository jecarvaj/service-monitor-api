class AddActiveFieldToScheduleDays < ActiveRecord::Migration[7.0]
  def change
    add_column :schedule_days, :active, :boolean, default: false
  end
end
