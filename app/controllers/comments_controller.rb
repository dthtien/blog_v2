class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article, only: :create
  before_action :find_comment,   only: [:update, :edit, :destroy]

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Commneted!"
    else
      flash[:alert] = "Can't comment"
    end
    redirect_to @article
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      flash[:notice] = "Comment was updated!"
    else
      flash[:alert] = "Comment couldn't be updated"
    end
    redirect_to @comment.article 
  end

  def destroy
    authorize @comment
    @comment.destroy
    flash[:notice] = "Comment was deleted!"
    redirect_to :back
  end

  private 
    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_comment
      @comment = Comment.find(params[id])
      @comment.user
    end

    def find_article
      @article = Article.find(params[:id])
    end
end
