class AddTextColorToEventTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :event_types, :text_color, :string, null: false, default: '#FFFFFF'
  end
end
