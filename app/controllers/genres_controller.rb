class GenresController < ApplicationController
  # before_action :authenticate!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    # 特定（今）のユーザーだけが新規保存できるようにする記述がわからない
    genre = Genre.new(genre_params)
    if genre.save(genre_params)
      flash[:notice] = "保存ができました！"
      redirect_to genres_path
    else
      flash.now[:alert] = "保存ができませんでした・・・"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
    # この下のif文のユーザー照合の仕方が合ってるかわからない
    # if @genre.admin_id == current_admin.id
    #   render :edit
    # else
    #   redirect_to admin_genres_path
    # end
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
     flash[:notice] = "更新ができました！"
     redirect_to genres_path
    else
     render :edit
      flash.now[:alert] = "更新ができませんでした・・・"
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
