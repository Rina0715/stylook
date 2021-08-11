class LikesController < ApplicationController


  def create
    @article = Article.find(params[:article_id])
    if @article.user_id != current_user.id   # 自分の投稿以外にお気に入り登録が可能
       @like = Like.create(user_id: current_user.id, article_id: params[:article_id])
    end
    # like = current_user.likes.new(article_id: @article.id)
    # like.save
    # @article.create_notification_like!(current_user)
    # 非同期処理のためredirect_toを削除
    # redirect_to article_path(article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @like = current_user.likes.find_by(article_id: @article.id)
    @like.destroy
    # 非同期処理のためredirect_toを削除
    # redirect_to article_path(article)
  end



end
