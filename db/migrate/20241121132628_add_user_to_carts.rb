class AddUserToCarts < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:carts, :user_id)
      add_reference :carts, :user, null: false, foreign_key: true
    end
  end
end
