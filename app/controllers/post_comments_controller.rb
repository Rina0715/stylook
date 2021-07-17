class PostCommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    @article.post_comments = @article.post_comments.order(created_at: :desc)
    comment = current_user.post_comments.new(post_comment_params)
    comment.article_id = article.id
    comment.save
    @article.create_notification_comment!(current_user, @post_comment.id)
    # redirect_to article_path(article) 　　#jsテンプレートを読み込む
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
