class LinksController < ApplicationController
  def index
    all_links = Link.order('created_at')
    @links = all_links.page(params[:page]).per(20)
  end

  def new
    @link = Link.new
    @user = User.find_by_id(session[:user_id])
  end

  def create
    @link = Link.new(params[:link])
    @user = User.find_by_id(session[:user_id])
    if @link.save
      redirect_to root_path, :notice => "Link created!"
    else
      render 'new'
    end
  end
end
