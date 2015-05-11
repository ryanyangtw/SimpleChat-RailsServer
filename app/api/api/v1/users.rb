module API
  module V1
    class Users < Grape::API

      @@default_user_path = 'v1/users'
      @@default_room_path = 'v1/rooms'
      @@default_message_path = 'v1/messages'

      resources :users do
        
        desc "Create User"        
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
            optional :name, type: String
            optional :avatar
          end
        end
        post "/sign_up" do

          #@user = User.new({email: params[:email], password: params[:password]})
          #puts "============================================================="
          #puts params
          #puts "============================================================="
          #puts params[:user]
          #puts "============================================================="
          @user = User.new(params[:user])
          if(@user.save)

            render rabl: "#{@@default_user_path}/show"
          else
            #raise
            error!(@user.errors.full_messages)
            #error_response({ message: "rescued from" })
            #error!("該使用者已經存在", 500)
          end
        end


        desc "User Sign in"
        params do
          optional :user, type: Hash do
            optional :email, type: String , documentation: { example: '123@gmail.com' }
            optional :password, type: String
          end
        end
        namespace :sign_in do
          post do
            
            @user = User.find_by_email(params[:user][:email])
            if(@user && @user.valid_password?(params[:user][:password]))

              render rabl: "#{@@default_user_path}/show"
            else
              error!(@user.errors.full_messages)
              #error!("401 Unauthorized", 401)
            end
          end
        end



        desc "List all of users"
        get '/' do
          @users = User.order(id: :desc)
          render rabl: "#{@@default_user_path}/index"
        end


        desc "List specific user"
        get '/:id' do
          @user = User.find(params[:id])
          render rabl: "#{@@default_user_path}/show"
        end



        desc "Get all rooms for specific user"
        get "/:id/rooms" do
          user = User.find(params[:id])
          @rooms = user.rooms.order(created_at: :desc)

          render rabl: "v1/rooms/index"

        end



        desc "Create message in specific room and user"
        params do
          requires :content, type: String
        end
        post ":id/rooms/:room_id/messages" do
          user = User.find(params[:id])
          room = user.rooms.find(params[:room_id])
          @message = Message.create(sender: user, room: room, content: params[:content])

          render rabl: "#{@@default_message_path}/show"
        end


        # desc "Notification list of users in specific room"
        # params do
        #   optional :user_ids, type: String
        # end
        # post "/notification" do
        #   binding.pry
        #   user_ids_arr = params[:user_ids].split(",")

        # end


        desc "Notification list of users in specific room"
        params do
          optional :user_ids, type: String
          optional :message, type: String
        end
        post "/:user_id/rooms/:id/notification" do
 
          sender = User.find(params[:user_id])
          room = Room.find(params[:id])
          all_member_ids = room.user_ids
          member_ids_who_has_get_message = params[:user_ids].split(",").map { |id| id.to_i }
          member_ids_who_did_not_get_message = all_member_ids - member_ids_who_has_get_message
          members_who_did_not_get_message = User.find(member_ids_who_did_not_get_message)

          members_who_did_not_get_message.each do |member|
            member.send_notigication(sender, params[:message])
          end

        end

    
      end   #resources user



    end
  end
end