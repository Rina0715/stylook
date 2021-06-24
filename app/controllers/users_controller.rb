class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order(created_at: :desc)
    # @articles = @user.articles.page(params[:page]).reverse_order
    favorites = Favorite.where(user_id: current_user.id).order(created_at: :desc).pluck(:article_id)
    @favorites = Article.find(favorites)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'relationships/follow_form'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'relationships/follow_form'
  end

  def destroy
    @user = current_user
    @user.update(is_valid: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def withdrawal
    @user = current_user
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end


end
