class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.date :init_date
      t.date :end_date

      t.timestamps
    end
  end
end
