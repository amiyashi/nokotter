class Recipe < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tag_relations, dependent: :destroy
  # 2つのモデル間の関連がrecipe_tag_relationsモデルを通じて行われる
  has_many :tags, through: :recipe_tag_relations
  belongs_to :customer
  # ActiveStorage導入
  has_one_attached :image

  # タグ機能
  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil? # タグが存在していれば、タグの名前を配列として全て取得
    old_tags = current_tags - tags # 現在取得したタグから、送られてきたタグを除く
    new_tags = tags - current_tags # 送信されてきたタグから、現在存在するタグを除く

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end

  # ブックマーク機能
  # 引数で渡されたidがBookmarksテーブルに存在（exists?）するか
  def favorited_by?(customer)
    bookmarks.exists?(customer_id: customer.id)
  end

end
