class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.integer :mark

      t.timestamps
    end
  end
end
