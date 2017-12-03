class AddEmployeeCountToOffices < ActiveRecord::Migration[5.1]
  def change
    change_table :offices do |t|
      t.integer :employees_count, null: false, default: 0
    end
  end
end