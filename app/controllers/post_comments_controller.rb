class PostCommentsController < ApplicationController

  def index
    # @new_article = Article.new
    @user = current_user
    @article = Article.find(params[:article_id])
    @post_comments = @article.post_comments
  end


  def create
    @post_comment = PostComment.new(post_comment_params)
    # @post_comment.user_id = current_user.id
    @article = Article.find(params[:article_id])
    @post_comment.save
    redirect_to article_path(@post_comment.article)
    # else
    #   # @new_article = Article.new
    #   @post_comments = @article.post_comments
    #   render "articles/show"
    # end
  end


  def destroy
    @post_comment = PostComment.find_by(id: params[:id], article_id: params[:article_id])
    @post_comment.destroy
    redirect_to article_path(@post_comment.article)
  end


  private
  def post_comment_params
    params.permit(:article_id, :content)
  end

end
