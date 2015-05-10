object @user 
#cache @user
attributes :id, :email, :name


node(:avatar) {|user| user.avatar_url }