class CreateWorkCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :work_centers do |t|
      t.string :name
      t.string :short_name
      t.string :description
      t.string :address
      t.boolean :status, null: false, default: true
      t.timestamps
    end
  end
end
