class Product < ApplicationRecord
  has_rich_text :description
  has_many_attached :images
  belongs_to :category, optional: true    
  has_many :cart_items
  # to make sure it doesnt have to have a category

  validates :name, presence: true, format: { with: /[a-zA-Z]/, message: "must include at least one letter" }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validate :description_cannot_be_only_numbers

  #custom validation
  def description_cannot_be_only_numbers
    if description.present? && description.to_plain_text.match?(/\A[0-9]+\z/)
      errors.add(:description, "cannot be only numbers")
    end
  end
end
