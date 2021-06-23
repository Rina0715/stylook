class SeasonsController < ApplicationController
  # before_action :authenticate!

  def index
    @seasons = Season.all
    @season = Season.new
  end

  def create
    # 特定（今）のユーザーだけが新規保存できるようにする記述がわからない
    @season = Season.new(season_params)
    if season.save(season_params)
      flash[:notice] = "保存ができました！"
      redirect_to seasons_path
    else
      flash.now[:alert] = "保存ができませんでした・・・"
      render :index
    end
  end

  def edit
    @season = Season.find(params[:id])
    # この下のif文のユーザー照合の仕方が合ってるかわからない
    # if @genre.admin_id == current_admin.id
    #   render :edit
    # else
    #   redirect_to admin_genres_path
    # end
  end

  def update
    @season = Season.find(params[:id])
    if season.update(season_params)
     flash[:notice] = "更新ができました！"
     redirect_to seasons_path
    else
     render :edit
      flash.now[:alert] = "更新ができませんでした・・・"
    end
  end

  private
  def season_params
    params.require(:season).permit(:name)
  end
end
