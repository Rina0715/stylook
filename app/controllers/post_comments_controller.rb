class PostCommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.article_id = article.id
    comment.save
    redirect_to article_path(article)
  end

  def destroy
    PostComment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    redirect_to article_path(params[:article_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end


end
