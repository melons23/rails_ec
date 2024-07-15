# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# product = Product.create(
#   name: 'テスト商品234',
#   price: '150',
#   description: 'テストテスト'
# )
# product.image.attach(io: File.open(Rails.root.join('app/assets/images/doubutu_penguin.png')),
#                   filename: 'doubutu_penguin.png')


4.times do |n|
  product = Product.create(
    name: "花束#{n + 1}",
    price: rand(100..1500),
    description: 'プレゼントに最適です。'
  ) 
  product.image.attach(io: File.open(Rails.root.join("app/assets/images/flower_#{n + 1}.jpg")),
                    filename: "flower_#{n + 1}.jpg")
end