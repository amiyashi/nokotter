class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, :amount, presence: true
end
