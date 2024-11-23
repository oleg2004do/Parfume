class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :phone_number
      t.string :delivery_method
      t.string :payment_method
      t.text :delivery_address

      t.timestamps
    end
  end
end
