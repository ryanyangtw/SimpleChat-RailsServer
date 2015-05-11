class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users, source: :room


  has_many :messages, dependent: :destroy


  def send_notigication(sender, message)
    puts "user: #{self.name} will norification self, message: #{message}"

    norification = "#{sender.name}: #{message}"
    data = { alert: norification }
    push = Parse::Push.new(data)
    #push.type = "ios"
    #query = Parse::Query.new("GameScore").eq("playerName", "Sean Plott")
    query = Parse::Query.new(Parse::Protocol::CLASS_INSTALLATION).eq('userId', self.id)
    
    push.where = query.where
    push.save

  end


end

#user.remote_avatar_url = avatar_url