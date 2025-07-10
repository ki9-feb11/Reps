class AddIndexToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_index :customers, :name
  end
end
