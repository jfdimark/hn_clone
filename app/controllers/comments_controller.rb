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
end
