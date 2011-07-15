class AddSidebarTitleAndShowInSidebarToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sidebar_title, :string
    add_column :pages, :show_in_sidebar, :boolean
  end
end
