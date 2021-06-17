class FavoritesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    if @article.user_id != current_user.id   # 自分の投稿以外にお気に入り登録が可能
      @favorite = Favorite.create(user_id: current_user.id, article_id: params[:article_id])
    end
  end
  def destroy
    @article = Article.find(params[:article_id])
    @favorite = Favorite.find_by(user_id: current_user.id, favorite_id: @favorite.id)
    @favorite.destroy
  end


end
