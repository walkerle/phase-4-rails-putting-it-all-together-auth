class RecipesController < ApplicationController

  def index
    user = User.find_by(id: session[:user_id])
    if user
      render json: Recipe.all, status: :created
    else
      render json: { errors: ["Not Authorized"] }, status: :unauthorized
    end
  end

  def create
    user = User.find_by(id: session[:user_id])
    if user
      recipe = user.recipes.create!(recipe_params)
      render json: recipe, status: :created
    else
      render json: { errors: ["Not Authorized"] }, status: :unauthorized
    end
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

end
