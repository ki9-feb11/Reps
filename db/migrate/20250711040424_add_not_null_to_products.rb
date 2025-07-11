class AddNotNullToProducts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :products, :name, false
    change_column_null :products, :manufacturer, false
    change_column_null :products, :category, false
    change_column_null :products, :wholesale_price, false
    change_column_null :products, :cost_price, false
  end
end
