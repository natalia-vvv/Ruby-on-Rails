class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.commenter = current_user.username
    @comment.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
      redirect_to article_path(@article)
    end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
