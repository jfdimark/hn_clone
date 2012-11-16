class LinksController < ApplicationController
  def index
    Link.update_points
    if (params[:order_by])
      all_links = Link.order("#{params[:order_by]} DESC")
    else
      all_links = Link.order('points DESC')
    end
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

  def edit
    @link = Link.find(params[:id])
    if @link.user.id == session[:user_id]
      @user = @link.user
    else
      redirect_to root_path, alert: "You are not authorized to edit this link."
    end
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(params[:link])
    redirect_to root_path
  end

  def destroy
    @link = Link.find(params[:id])
    if @link.user.id == session[:user_id]
      @link.destroy
      redirect_to root_path
    else
      redirect_to root_path, alert: "You are not authorized to edit this link."
    end
  end

end
