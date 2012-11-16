class CommentsController < ApplicationController

  def index
    @link = Link.find_by_id(params[:link_id])
    @comment = Comment.new
    @comments = Comment.find_all_by_link_id(params[:link_id])
  end

  def create
    @link = Link.find_by_id(params[:link_id])
    @comment = Comment.new(params[:comment])
    if @comment.save
      @link.increment!(:comment_count)
      redirect_to link_comments_path(@link), :notice => "Comment created!"
    else
      render "index"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @link = @comment.link
    if @comment.user.id == session[:user_id]
      if @comment.editable?
        @user = @comment.user
      else
        redirect_to link_comments_path(@link), alert: "Comment editing period has ended."
      end
    else
      redirect_to link_comments_path(@link), alert: "You are not authorized to edit this comment."
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @link = @comment.link
    @comment.update_attributes(params[:comment])
    redirect_to link_comments_path(params[:link_id]), :notice => "Comment updated!"
  end

  # def destroy
  #  @comment = Comment.find(params[:id])
  #   if @comment.user.id == session[:user_id]
  #     @comment.destroy
  #     redirect_to link_comments_path(params[:link_id])
  #   else
  #     redirect_to link_comments_path(params[:link_id]), alert: "You are not authorized to edit this link."
  #   end
  # end

end
