class Season < ApplicationRecord

  has_many :articles, through: :article_seasons
  validates :name, presence: true

end
