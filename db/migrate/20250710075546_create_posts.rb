class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.integer :status
      t.integer :result_status
      t.integer :reaction
      t.text :result_notes

      t.timestamps
    end
  end
end
