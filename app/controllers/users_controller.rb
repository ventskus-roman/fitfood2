class UsersController < ApplicationController
  before_action :find_user

  def recipes
    @recipes = Recipe.where(user_id: params[:user_id]).paginate(:page => params[:page], per_page: 5).order("created_at DESC")
  end

  def subscribe
    current_user.users << @user
    redirect_to user_recipes_path(@user)
  end

  def unsubscribe
    current_user.users.delete(@user)
    redirect_to user_recipes_path(@user)
  end

  def news
    @recipes = Recipe.where(user: current_user.users).paginate(:page => params[:page], per_page: 5).order("created_at DESC")
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
