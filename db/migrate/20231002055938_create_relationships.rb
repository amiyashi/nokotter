class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :followed_id, null: false
      t.integer :follower_id, null: false
      t.timestamps
    end
      add_index :relationships, :followed_id
      add_index :relationships, [:follower_id, :followed_id], unique: true
      # 同じ人を2回フォローするのを防ぐ
  end
end
