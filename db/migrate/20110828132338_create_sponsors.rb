class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.text :description
      t.text :url
      t.text :image

      t.timestamps
    end
  end
end
