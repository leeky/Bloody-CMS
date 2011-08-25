class AddAllDayEventToEvents < ActiveRecord::Migration
  def change
    add_column :events, :all_day_event, :boolean
  end
end
