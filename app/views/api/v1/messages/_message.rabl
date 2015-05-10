object @message 
#cache @user
attributes :id, :content


child :sender => "sender" do
  attributes :id, :name
end


