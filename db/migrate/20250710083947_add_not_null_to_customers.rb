class AddNotNullToCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :customers, :name, false
    change_column_null :customers, :adress, false
    change_column_null :customers, :industry, false
    change_column_null :customers, :contact_person, false
    change_column_null :customers, :key_person, false
  end
end
