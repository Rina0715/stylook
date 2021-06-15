class CreateArticleGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :article_genres do |t|

      t.timestamps
    end
  end
end
