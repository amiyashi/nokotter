class Tag < ApplicationRecord
  has_many :recipe_tag_relations, dependent: :destroy
  has_many :recipes, through: :recipe_tag_relations
  # 2つのモデル間の関連がrecipe_tag_relationsモデルを通じて行われる
end