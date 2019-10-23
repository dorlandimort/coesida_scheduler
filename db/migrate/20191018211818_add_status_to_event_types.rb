class AddStatusToEventTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :event_types, :status, :boolean, null: false, default: true
  end
end
