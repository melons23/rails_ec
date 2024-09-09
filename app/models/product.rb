class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  has_one_attached :image
  has_many :cart_items, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[image_attachment image_blob]
  end

  ransacker :id do
    Arel.sql("to_char(#{table_name}.id, '9999999')")
  end
end
