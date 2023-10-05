class CreateRecipeTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_tag_relations do |t|
      t.integer :recipe_id, null: false
      t.integer :tag_id, null: false
      t.timestamps
    end
    # 同じタグは２回保存出来ない
    add_index :recipe_tag_relations, [:recipe_id,:tag_id],unique: true
  end
end
