class SessionsController < ApplicationController

  before_action :set_user, only: [:create]

  def create
    # user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      render json: @user, status: :created
    else
      render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    end
  end

  def destroy
    if session[:user_id]
      session.delete :user_id
      head :no_content
    else
      render json: {errors: ["Not Authorized"] }, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

end
