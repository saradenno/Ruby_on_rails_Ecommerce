class Category < ApplicationRecord
  has_many :products
  has_one_attached :image
  has_rich_text :description
end
