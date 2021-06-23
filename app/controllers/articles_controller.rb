class ArticlesController < ApplicationController

  def new
    @article = Article.new
    @genres = Genre.all
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def index                                   #order(created_at: :desc)で投稿を新着順に！
    @articles = Article.page(params[:page]).order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
    @post_comment = PostComment.new
    @user = current_user
  end

  def destroy
    @article = Article.find(params[:id])  # データ（レコード）を1件取得
    @article.destroy  # データ（レコード）を削除
    redirect_to articles_path  # 投稿一覧画面へリダイレクト
  end


  private

  def article_params
    params.require(:article).permit(:image, :caption, :genre_id, :season)
  end


end
