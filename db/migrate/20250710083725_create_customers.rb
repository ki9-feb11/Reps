class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :adress
      t.string :industry
      t.string :contact_person
      t.string :key_person
      t.text :notes

      t.timestamps
    end
  end
end
