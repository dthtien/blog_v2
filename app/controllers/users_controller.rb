class UsersController < ApplicationController
  def show
    @user = User.includes(:articles).find(params[:id])
  end
end
