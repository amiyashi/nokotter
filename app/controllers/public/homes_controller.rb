class Public::HomesController < ApplicationController
  def top
    # Bookmarkテーブルの中にある、recipe_idが重複するレコードを並べ替え
    # count(recipe_id)したデータをDESC（降順）で並べ替え
    # Bookmarkテーブルに保存されているrecipe_idが同じものを数える
    # 指定したカラムの値の配列を、対応するデータ型で返す
    @ranks = Recipe.find(Bookmark.group(:recipe_id).order('count(recipe_id) DESC').limit(5).pluck(:recipe_id))
  end
  
  def about
  end
end
