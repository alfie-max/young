class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body
      t.references :category, foreign_key: true
      t.string :image
      t.string :other_image
      t.string :author

      t.timestamps
    end
  end
end
