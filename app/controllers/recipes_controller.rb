class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  autocomplete :product, :name, :extra_data => [:proteins, :carbs, :fat]

  def index
    @recipes = Recipe.all.order("created_at DESC")
  end

  def show
    proteins = 0
    carbs = 0
    fat = 0
    calories = 0
    weight = 0
    @recipe.ingredients.each do |ingredient|
      proteins = proteins + ingredient.product.proteins * (ingredient.weight / 100)
      carbs = carbs + ingredient.product.carbs * (ingredient.weight / 100)
      fat = fat + ingredient.product.fat * (ingredient.weight / 100)
      weight = weight + ingredient.weight
    end
    calories = proteins * 4 + carbs * 4 + fat * 9
    @recipe.calories = calories.round.to_i
    @recipe.proteins = proteins.round.to_i
    @recipe.carbs = carbs.round.to_i
    @recipe.fat = fat.round.to_i
    @recipe.weight = weight.round
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :proteins, :carbs, :fat, :description, :image)
  end

end
