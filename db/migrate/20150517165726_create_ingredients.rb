class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :recipe_id
      t.integer :product_id
      t.float :weight

      t.timestamps null: false
    end
  end
end
