class AddIndexToPosts < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, :result_status
    add_index :posts, :reaction
  end
end
