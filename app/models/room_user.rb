class RoomUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :room, counter_cache: :userz_count
end
