class Recipe < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tag_relations, dependent: :destroy
  belongs_to :customer
  # ActiveStorage導入
  has_one_attached :image
end
