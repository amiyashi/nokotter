class Recipe < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tag_relations, dependent: :destroy
  # 2つのモデル間の関連がrecipe_tag_relationsモデルを通じて行われる
  has_many :tags, through: :recipe_tag_relations
  belongs_to :customer

  has_many :procedures, dependent: :destroy
  accepts_nested_attributes_for :procedures, reject_if: :all_blank, allow_destroy: true
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  #関連付けしたモデルを一緒にデータ保存できるようにする記述
  accepts_nested_attributes_for :procedures, allow_destroy: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true

  # タグ機能
  def save_tags(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil? # タグが存在していれば、タグの名前を配列として全て取得
    old_tags = current_tags - sent_tags # 現在取得したタグから、送られてきたタグを除く
    new_tags = sent_tags - current_tags # 送信されてきたタグから、現在存在するタグを除く
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
    # 新しいタグを保存する
    new_tags.each do |new_name|
      new_recipe_tag = Tag.find_or_create_by(name:new_name)
      self.tags << new_recipe_tag
    end
  end
  # ブックマーク機能
  # 引数で渡されたcustomer_idがBookmarksテーブルに存在するか
  def favorited_by?(customer)
    bookmarks.exists?(customer_id: customer.id)
  end
  # 検索機能
  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tags"]
  end
end
