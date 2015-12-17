class UsersController < ApplicationController
  before_action :require_login, except: [:create]
  before_action :require_correct_user, only: [:show, :edit, :destroy]
  def create
    user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email],  city: params[:city],  state: params[:state], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      flash[:errors] = user.errors.full_messages
      session[:user_id] = nil
      redirect_to '/sessions/new'
    end
  end

  def show
    @user = User.find(params[:id])
    # @eventshere = Event.find_by_state(@user.state)
    @events_here = Event.where(state: @user.state)
    @events_away = Event.where.not(state: @user.state)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], city: params[:city], state: params[:state])
    if user.valid?
      user.save
      flash[:success] = "Your profile has been successfully updated"
      redirect_to "/users/#{user.id}/edit"
      else
      flash[:errors] = user.errors.full_messages
      redirect_to "/users/#{user.id}/edit"
    end
  end
  def destroy 
    User.delete(params[:id])
    session[:user_id] = nil
    redirect_to '/sessions/new'
  end
end
