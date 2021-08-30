class CreateBusinessDays < ActiveRecord::Migration[5.2]
  def change
    create_table :business_days do |t|
      t.date  :date, null: false
      t.boolean :weekend_operation, default: false, null: false
      t.integer :max_of_13
      t.integer :max_of_14
      t.integer :max_of_15
      t.integer :max_of_16
      t.integer :max_of_17
      t.integer :max_of_18
      t.integer :max_of_19
      t.integer :max_of_20
      t.integer :max_of_21
      t.references :month, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.timestamps
    end
  end
end
