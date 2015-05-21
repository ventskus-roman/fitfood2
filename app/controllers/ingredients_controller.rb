class IngredientsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    if (params[:ingredient][:product_id] && !params[:ingredient][:product_id].empty?)
      @ingredient = @recipe.ingredients.create(params[:ingredient].permit(:product_id, :weight))
      flash[:error] = "Не удалось добавить компонент. Проверьте введенные значения" if !@ingredient.valid?
      redirect_to edit_recipe_path(@recipe)
    else 
      product_params = params[:ingredient]
      @product = Product.new(name: product_params[:product_name], proteins: product_params[:product_proteins], carbs: product_params[:product_carbs],
                                fat: product_params[:product_fat])
      if (@product.save)
        @ingredient = @recipe.ingredients.create(product_id: @product.id, weight: product_params[:weight])
        redirect_to edit_recipe_path(@recipe)
      else
        flash.now[:error] = "Не удалось добавить продукт"
        render '/recipes/edit'
      end
    end
    @recipe.save
  end

end
