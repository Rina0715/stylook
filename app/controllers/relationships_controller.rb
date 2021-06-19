class RelationshipsController < ApplicationController
  before_action :set_user

  #フォロー機能を作成・保存・削除
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  #フォロー・フォロワー一覧を表示
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end



  private

  def set_user
    @user = User.find(params[:relationship, :followed_id])
  end


end
