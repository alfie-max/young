class CreateAdverts < ActiveRecord::Migration[5.2]
  def change
    create_table :adverts do |t|
      t.string :title
      t.string :image
      t.string :url
      t.integer :status
      t.string :desc

      t.timestamps
    end
  end
end
