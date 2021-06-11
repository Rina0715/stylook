class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.save
    redirect_to articles_path
  end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    article = Article.find(params[:id])  # データ（レコード）を1件取得
    article.destroy  # データ（レコード）を削除
    redirect_to articles_path  # 投稿一覧画面へリダイレクト
  end

  private

  def article_params
    params.require(:article).permit(:image, :caption)
  end

end
