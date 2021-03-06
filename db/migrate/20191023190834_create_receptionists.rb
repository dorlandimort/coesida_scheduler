class CreateReceptionists < ActiveRecord::Migration[5.2]
  def change
    create_table :receptionists do |t|
      t.boolean :status, null: false, default: true
      t.references :user, foreign_key: true
      t.references :work_center, foreign_key: true

      t.timestamps
    end
  end
end
