class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :manufacturer
      t.string :category
      t.decimal :list_price
      t.decimal :wholesale_price
      t.decimal :cost_price

      t.timestamps
    end
  end
end
