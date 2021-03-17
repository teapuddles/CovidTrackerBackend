class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.text :description
      t.string :title
      t.string :author
      t.string :url
      t.string :urlToImage
      t.string :publishedAt
      t.text :content

      t.timestamps
    end
  end
end
