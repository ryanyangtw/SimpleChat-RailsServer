class Message < ActiveRecord::Base

  belongs_to :sender, class_name: "User", foreign_key: :user_id
  belongs_to :room


end
