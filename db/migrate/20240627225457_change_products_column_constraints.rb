class ChangeProductsColumnConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :name, :price, false
    add_index :products, :name, unique: true
  end
end
