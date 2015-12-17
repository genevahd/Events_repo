class JoinsController < ApplicationController
  def create
  	user = User.find(session[:user_id])
  	Join.create(user: User.find(session[:user_id]), event: Event.find(params[:id]))
  	redirect_to "/users/#{user.id}"
  end

  def destroy
  	user = User.find(session[:user_id])
  	Join.find_by(event: Event.find(params[:id]), user: User.find(session[:user_id])).delete
  	redirect_to "/users/#{user.id}"
  end
end
