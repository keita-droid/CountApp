class CreateMonths < ActiveRecord::Migration[5.2]
  def change
    create_table :months do |t|
      t.date        :month, null: false, unique: true
      t.timestamps
    end
  end
end
