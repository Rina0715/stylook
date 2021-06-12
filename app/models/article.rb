class Article < ApplicationRecord

  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy

end
