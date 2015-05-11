module API
  module V1
    class Rooms < Grape::API

      @@default_room_path = 'v1/rooms'
      @@default_message_path = 'v1/messages'

      resources :rooms do
        

        desc "Get or Create Room"        
        params do
          requires :creater_id, type: String
          requires :friend_id, type: String
        end
        post do

          creater = User.find(params[:creater_id]) #.where(userz_count: 2)
          friend = User.find(params[:friend_id]) #.where(userz_count: 2)

          creater_room_list = creater.rooms.where(userz_count: 2) #creater_room_ids
          friend_room_list = friend.rooms.where(userz_count: 2)

          intersection = (creater_room_list & friend_room_list)

          
          if !intersection.empty?
            @room = intersection.first
          else
            @room = Room.create(name: friend.name, avatar: friend.avatar)
            @room.users << creater
            @room.users << friend

          end

          render rabl: "#{@@default_room_path}/show"
        end



        desc "Get messages in specific rooms"
        paginate per_page: 10
        get "/:room_id/messages" do
          room = Room.find(params[:room_id])
          unreverse_messages = paginate room.messages.order(id: :desc) #.reverse_order
          @messages = unreverse_messages.reverse

          render rabl: "#{@@default_message_path}/index"
        end


        desc "Notification list of users in specific room"
        params do
          optional :user_ids, type: String
          optional :message, type: String
        end
        post "/:id/notification" do
 
          room = Room.find(params[:id])
          all_member_ids = room.user_ids
          member_ids_who_has_get_message = params[:user_ids].split(",").map { |id| id.to_i }
          member_ids_who_did_not_get_message = all_member_ids - member_ids_who_has_get_message
          members_who_did_not_get_message = User.find(member_ids_who_did_not_get_message)

          members_who_did_not_get_message.each do |member|
            member.send_notigication(params[:message])
          end

        end

    
      end   #resources user



    end
  end
end