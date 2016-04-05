class CommentsController < ApplicationController
    before_action :require_sign_in
    before_action :authorize_user, only: [:destroy]
    
    def create
        if params[:topic_id]
            @topic = Topic.find(params[:topic_id])
            comment = @topic.comments.new(comment_params)
            comment.user = current_user
            if comment.save
                flash[:notice] = "Comment saved successfully."
                redirect_to @topic
            else
                flash[:alert] = "Comment failed to save."
                redirect_to @topic
            end 
        else
            @post = Post.find(params[:post_id])
            comment = @post.comments.new(comment_params)
            comment.user = current_user
            if comment.save
                flash[:notice] = "Comment saved successfully."
                redirect_to [@post.topic, @post]
            else
                flash[:alert] = "Comment failed to save."
                redirect_to [@post.topic, @post]
            end
        end
    end
    
    def destroy
        if params[:topic_id]
            @topic = Topic.find(params[:topic_id])
            comment = @topic.comments.find(params[:id])
            if comment.destroy
                flash[:notice] = "Comment was deleted successfully."
                redirect_to @topic
            else
                flash[:alert] = "Comment couldn't be deleted. Please try again."
                redirect_to @topic
            end 
        else
            @post = Post.find(params[:post_id])
            comment = @post.comments.find(params[:id])
            if comment.destroy
                flash[:notice] = "Comment was deleted successfully."
                redirect_to [@post.topic, @post]
            else
                flash[:alert] = "Comment couldn't be deleted. Please try again."
                redirect_to [@post.topic, @post]
            end
        end
    end
    
    private #######################
    
    def comment_params
        params.require(:comment).permit(:body)
    end
    def authorize_user
        comment = Comment.find(params[:id])
        unless current_user == comment.user || current_user.admin?
            flash[:alert] = "You do not have permission to delete this comment."
            if params[:topic_id]
                redirect_to comment.topic
            else
                redirect_to [comment.post.topic, comment.post]
            end
        end
    end
end
