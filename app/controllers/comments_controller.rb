class CommentsController < ApplicationController
  def create
  	@user = User.find(session[:user_id])
  	@event = Event.find(params[:id])
  	comment = Comment.new(content: params[:content], user: @user, event: @event)
  	if comment.valid? 
  		comment.save
  		redirect_to "/events/#{@event.id}"
  	else
  		flash[:errors] = comment.errors.full_messages
  		redirect_to "/events/#{@event.id}"
  	end
  end
end
