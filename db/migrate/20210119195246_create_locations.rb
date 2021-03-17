class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :country
      t.string :flag
      t.string :ISO
      t.integer :confirmed
      t.integer :deaths
      t.integer :active
      t.integer :recovered
      t.float :lat
      t.float :lon
      t.string :date
      t.integer :user_id
      t.integer :vaccinations

      t.timestamps
    end
  end
end
