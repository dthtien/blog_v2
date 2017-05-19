class UsersController < ApplicationController
  def show
    @user = User.includes(:articles).find(params[:id])
    @articles = @user.articles.paginate(page: params[:page])
  end
end
