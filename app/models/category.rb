class Category < ApplicationRecord
  has_many :products
  has_one_attached :image
  has_rich_text :description

  validates :name, presence: true
  validates :description, presence: true
end
