class Room < ActiveRecord::Base

  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users, source: :user


  has_many :messages, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

end
