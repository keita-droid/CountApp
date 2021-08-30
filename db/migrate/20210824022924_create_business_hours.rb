class CreateBusinessHours < ActiveRecord::Migration[5.2]
  def change
    create_table :business_hours do |t|
      t.integer :current_stay, default: 0
      t.integer :maximum_stay, default: 0
      t.integer :coming, default: 0
      t.integer :leaving, default: 0
      t.integer :leave_count, default: 0
      t.integer :hour, null: false
      t.references :business_day, null: false, foreign_key: true
      t.timestamps
    end
  end
end
