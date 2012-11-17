class VotesController < ApplicationController
  def create
    unless session[:user_id]
      redirect_to root_url, :alert => "You must be logged in to vote."
      return
    end

    object_type = params[:object_id].class.to_s
    @vote = Vote.new(:user_id => session[:user_id], :object_id => params[:object_id], :object_type => object_type )
    #need to rework the votable? method to account for links or comments
    if @vote.save
      redirect_to :back, :notice => "Upvoted!"
    else
      redirect_to :back, :alert => "You are not allowed to vote."
    end
  end



end
