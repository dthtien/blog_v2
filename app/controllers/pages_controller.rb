class PagesController < ApplicationController
  def home
    @articles = Article.includes(:user).paginate(page: params[:page])
  end
end
