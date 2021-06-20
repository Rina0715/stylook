class MyfavoritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @myfavorites = @user.favorites
  end
end