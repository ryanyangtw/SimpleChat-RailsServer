class AddUserzCountToRooms < ActiveRecord::Migration
  def change
     add_column :rooms, :userz_count, :integer, default: 0
  end
end
