class Category < ApplicationRecord
  has_many :products
  has_one_attached :image
  has_rich_text :description

  validates :name, presence: true, format: { with: /[a-zA-Z]/, message: "must include at least one letter" }
  validates :description, presence: true
  validate :description_cannot_be_only_numbers

  #custom validation
  def description_cannot_be_only_numbers
    if description.present? && description.to_plain_text.match?(/\A[0-9]+\z/)
      errors.add(:description, "cannot be only numbers")
    end
  end
end
