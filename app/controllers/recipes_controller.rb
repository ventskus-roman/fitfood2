class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :vote]

  autocomplete :product, :name, :extra_data => [:proteins, :carbs, :fat]

  def index
    if params[:tag]
    @recipes = Recipe.tagged_with(params[:tag]).paginate(:page => params[:page], per_page: 5).order("created_at DESC")
  else
    @recipes = Recipe.paginate(:page => params[:page], per_page: 5).order("created_at DESC")
  end
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to edit_recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to edit_recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  def vote
    value = params[:type] == 'up' ? 1 : -1
    @recipe.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Спасибо за ваш голос"
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :proteins, :carbs, :fat, :description, :image, :has_ingredients, :tag_list)
  end

  def tags
  end

end
