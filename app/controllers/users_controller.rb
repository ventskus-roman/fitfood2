class UsersController < ApplicationController

  def recipes
    @user = User.find(params[:user_id])
    @recipes = Recipe.where(user_id: params[:user_id])
  end
end
