class AddIndexToProducts < ActiveRecord::Migration[6.1]
  def change
    add_index :products, :manufacturer
    add_index :products, :category
  end
end
