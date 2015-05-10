object @room 
#cache @user
attributes :id, :name

node(:avatar) {|room| room.avatar_url }
node(:last_message){|room| room.messages.last.try(:content)}
node(:last_message_created_at){|room| room.messages.last.present? ? time_ago_in_words(room.messages.last.created_at) : "從未開啟對話"}

child :users => "memebers" do
  extends "v1/users/_user"
end