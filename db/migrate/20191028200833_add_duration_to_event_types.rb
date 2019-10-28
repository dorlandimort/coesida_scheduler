class AddDurationToEventTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :event_types, :duration, :integer, null: false, default: 30
  end
end
