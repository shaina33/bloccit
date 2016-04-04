class PostsController < ApplicationController
# index action no longer needed due to nesting
#   def index
#     @posts = Post.all
#     # optional SPAM filter:
#     # @posts.each do |post|
#     #   if (post.id == 1) || (post.id % 5 == 1)
#     #     post.title = "SPAM"
#     #   end
#     # end
#   end

  before_action :require_sign_in, except: :show
  before_action :authorize_update, except: [:show, :new, :create]
  before_action :authorize_user, except: [:show, :new, :create, :edit, :update]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def create
   @topic = Topic.find(params[:topic_id])
   @post = @topic.posts.build(post_params)
   @post.user = current_user
  
   if @post.save
     flash[:notice] = "Post was saved."
     @post.labels = Label.update_labels(params[:post][:labels])
     redirect_to [@topic, @post]
   else
     flash.now[:alert] = "There was an error saving the post. Please try again."
     render :new
   end
  end
  
  def update
     @post = Post.find(params[:id])
     @post.assign_attributes(post_params)
  
     if @post.save
       flash[:notice] = "Post was updated."
       @post.labels = Label.update_labels(params[:post][:labels])
       redirect_to [@post.topic, @post]
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :edit
     end
  end
  def destroy
     @post = Post.find(params[:id])
 
     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to @post.topic
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
  end
  
  private #################################
  def post_params
      params.require(:post).permit(:title, :body)
  end
  def authorize_update
      post = Post.find(params[:id])
      unless current_user == post.user || (current_user.moderator? || current_user.admin?)
        flash[:alert] = "You must be a moderator or administrator to do this action."
        redirect_to [post.topic, post]
      end
  end
  def authorize_user
      post = Post.find(params[:id])
      unless current_user == post.user || current_user.admin?
        flash[:alert] = "You must be an administrator to do this action."
        redirect_to [post.topic, post]
      end
  end
end
