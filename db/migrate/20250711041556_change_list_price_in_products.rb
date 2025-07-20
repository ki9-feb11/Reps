class ChangeListPriceInProducts < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :list_price, :decimal, precision: 10, scale: 2
    change_column :products, :wholesale_price, :decimal, precision: 10, scale: 2
    change_column :products, :cost_price, :decimal, precision: 10, scale: 2
  end
end
