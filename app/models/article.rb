class Article < ApplicationRecord

  belongs_to :user
  attachment :image

  #投稿を時間の降順に並び替える
  default_scope -> { order(created_at: :desc) }

  has_many :post_comments, dependent: :destroy

end
