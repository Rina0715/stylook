class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :article

  mount_uploader :image, ImagesUploader

end
