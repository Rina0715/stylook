class LikesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    like = current_user.likes.new(article_id: @article.id)
    like.save
    @article.create_notification_like!(current_user)
    # 非同期処理のためredirect_toを削除
    # redirect_to article_path(article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    like = current_user.likes.find_by(article_id: @article.id)
    like.destroy
    # 非同期処理のためredirect_toを削除
    # redirect_to article_path(article)
  end


end
