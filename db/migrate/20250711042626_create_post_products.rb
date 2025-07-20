class CreatePostProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :post_products do |t|
      t.references :post, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
