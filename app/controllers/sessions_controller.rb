class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_or_create_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
    user.username = auth_hash[:info][:nickname]
    user.save if user.changed?
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
