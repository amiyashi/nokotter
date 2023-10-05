class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.timestamps
    end
    # 同じタグは２回保存出来ない
    add_index :tags, :name, unique:true
  end
end
