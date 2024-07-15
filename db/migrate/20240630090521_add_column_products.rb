class AddColumnProducts < ActiveRecord::Migration[7.0]
  def up
    add_column :products, :image, :string
  end
end
