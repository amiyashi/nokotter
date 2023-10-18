class CreateProcedures < ActiveRecord::Migration[6.1]
  def change
    create_table :procedures do |t|
      t.references :recipe, foreign_key: true
      t.text :body, null: false
      t.timestamps
    end
  end
end
