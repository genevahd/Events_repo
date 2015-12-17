class EventsController < ApplicationController
  def create
  	@user = User.find(session[:user_id])
  	event = @user.events.new(name: params[:name], date: params[:date], city: params[:city], state: params[:state])
  	if event.valid?
  		event.save
  		redirect_to "/users/#{@user.id}"
  	else
  		flash[:errors] = event.errors.full_messages
  		redirect_to "/users/#{@user.id}"
  	end
  end
  def show
  	@user = User.find(session[:user_id])
  	@event = Event.find(params[:id])
  end

  def destroy
  	@user = User.find(session[:user_id])
  	@event = Event.find(params[:id])
  	Event.find(params[:id]).delete if @user == current_user
  	redirect_to "/users/#{@user.id}"
  end

  def edit
  	@user = User.find(session[:user_id])
  	@event = Event.find(params[:id])
  end
  def update
  	@user = User.find(session[:user_id])
  	@event = Event.find(params[:id])
  	event = Event.find(params[:id])
    event.update(name: params[:name], date: params[:date], city: params[:city], state: params[:state])
    if event.valid?
      event.save
      flash[:success] = "Your event has been successfully updated"
      redirect_to "/events/#{event.id}/edit"
      else
      flash[:errors] = event.errors.full_messages
      redirect_to "/events/#{event.id}/edit"
    end
  end
end
