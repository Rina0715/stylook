class AddProfileImageIdToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :profile_image_id, :string
  end
end
