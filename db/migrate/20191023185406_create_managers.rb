class CreateManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :managers do |t|
      t.string :description
      t.boolean :status, null: false, default: true
      t.references :user, foreign_key: true
      t.references :work_center, foreign_key: true
      t.timestamps
    end
  end
end
