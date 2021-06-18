class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  # def active_for_authentication?
  #   super && (self.is_valid == false)
  # end

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  #ユーザーをフォローする
  def follow(user_id)
    unless self.id == user_id
      self.relationships.find_or_create_by(followed_id: user_id)
    end
  end

  #ユーザーをアンフォローする
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  #現在のユーザーがフォローしてたらtrueを返す
  def following?(user)
    followings.include?(user)
  end


  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'following'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'following'
      )
      notification.save if notification.valid?
    end
  end


end
