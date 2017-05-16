class PagesController < ApplicationController
  def home
    @articles = Article.includes(:user).all.paginate(page: params[:page])
  end
end
