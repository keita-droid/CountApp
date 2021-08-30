class AddColumnsToSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :name, :string, null: false
    add_column :schools, :seats, :integer, null: false
  end
end
