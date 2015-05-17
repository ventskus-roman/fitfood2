class IngredientsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.create(params[:ingredient].permit(:product_id, :weight))

    redirect_to recipe_path(@recipe)
  end
end
