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
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:image, :caption)
  end

end
