class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.text :review
      t.datetime :published_at
      t.string :address
      t.datetime :start_date
      t.datetime :end_date
      t.string :venue
      t.string :signup_url

      t.timestamps
    end
  end
end
