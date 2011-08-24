class AddSlugToEvents < ActiveRecord::Migration
  def change
    add_column :events, :slug, :text
  end
end
