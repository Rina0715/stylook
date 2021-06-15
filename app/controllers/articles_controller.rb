class ArticlesController < ApplicationController

  def new
    @article = Article.new
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

  def index
    @articles = Article.page(params[:page]).reverse_order
    @user = current_user
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
    params.require(:article).permit(:image, :caption)
  end


end
