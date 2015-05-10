module API
  module V1
    class Messages < Grape::API

      @@default_message_path = 'v1/messages'

      resources :messages do
        

        # desc "Get messages in specific rooms"
        # paginate per_page: 15
        # get "/:room_id/messages" do
        #   room = Room.find(params[:room_id])
        #   @messages = paginate room.messages.order(created_at: :desc)

        #   render rabl: "#{@@default_message_path}/index"
        # end


        # desc "Post message"
        # post "rooms/:room_id/" do
        # end

      end   #resources messages


      resources :rooms do




        # desc "Post message"
        # post "ro
      end




    end
  end
end