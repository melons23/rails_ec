class RemoveForeignKeyFromCartItems < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :cart_items, :products
  end
end
