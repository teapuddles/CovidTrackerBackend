class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :country
      t.string :flag
      t.string :ISO
      t.bigint :confirmed
      t.bigint :deaths
      t.bigint :active
      t.bigint :recovered
      t.float :lat
      t.float :lon
      t.string :date
      t.bigint :user_id
      t.bigint :vaccinations

      t.timestamps
    end
  end
end
