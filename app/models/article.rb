class Article < ApplicationRecord

  belongs_to :user
  attachment :image

  #投稿を時間の降順に並び替える
  default_scope -> { order(created_at: :desc) }

  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :article_genres, dependent: :destroy
  has_many :genres, through: :article_genres

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
