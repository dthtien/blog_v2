class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_article, except: [:new, :create]

  def show
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = "Article was created!"
      redirect_to @article
    else
      flash.now[:alert] = "Can't create article"
      render :new
    end
  end

  def edit
    authorize @article
  end

  def update
    authorize @article
    if @article.update(article_params)
      flash[:notice] = "Article was updated"
      redirect_to @article
    else
      flash.now[:alert] = "Can't update article"
      render :new
    end
  end

  def destroy
    authorize @article
    @article.destroy
    flash[:notice] = "Article was deleted"
    redirect_to :back
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :image)
    end

    def find_article
      @article = Article.includes(:user, :comments).find(params[:id])
    end
end
