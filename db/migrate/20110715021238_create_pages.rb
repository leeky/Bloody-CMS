class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :title
      t.text :content
      t.text :slug
      t.datetime :published_at
      t.integer :order

      t.timestamps
    end
  end
end
