class AddHasIngredientsToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :has_ingredients, :boolean, default: false
  end
end
