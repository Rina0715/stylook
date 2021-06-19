class Genre < ApplicationRecord

  # has_many :article_genres, dependent: :destroy
  has_many :articles, through: :article_genres
  validates :name, presence: true

end
