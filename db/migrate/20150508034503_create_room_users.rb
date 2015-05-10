class CreateRoomUsers < ActiveRecord::Migration
  def change
    create_table :room_users do |t|

      t.integer :user_id, index: true
      t.integer :room_id, index: true
      t.timestamps null: false
    end
  end
end
