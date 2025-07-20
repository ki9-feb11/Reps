class AddNotNullToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :title, false
    change_column_null :posts, :body, false
    change_column_null :posts, :status, false
    change_column_null :posts, :result_status, false
    change_column_null :posts, :reaction, false
  end
end
