class AddNotNullConstraiontsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :last_name, false
    change_column_null :users, :first_name, false
    change_column_null :users, :position, false
    change_column_null :users, :region, false
  end
end
