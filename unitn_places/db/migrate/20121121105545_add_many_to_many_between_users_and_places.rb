class AddManyToManyBetweenUsersAndPlaces < ActiveRecord::Migration
  def change
    create_table :places_users, :id => false do |t|
      t.integer :place_id
      t.integer :user_id

      t.timestamps
    end
  end
end
