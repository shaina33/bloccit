class SponsoredpostsController < ApplicationController
  def show
    @spost = Sponsoredpost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @spost = Sponsoredpost.new
  end
  
  def create
    @spost = Sponsoredpost.new
    @spost.title = params[:sponsoredpost][:title]
    @spost.body = params[:sponsoredpost][:body]
    @spost.price = params[:sponsoredpost][:price]
    @topic = Topic.find(params[:topic_id])
    @spost.topic = @topic
    
    if @spost.save
      flash[:notice] = "Sponsored post was saved."
      redirect_to [@topic, @spost]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @spost = Sponsoredpost.find(params[:id])
  end
  
  def update
     @spost = Sponsoredpost.find(params[:id])
     @spost.title = params[:sponsoredpost][:title]
     @spost.body = params[:sponsoredpost][:body]
     @spost.price = params[:sponsoredpost][:price]
  
     if @spost.save
       flash[:notice] = "Sponsored post was updated."
       redirect_to [@spost.topic, @spost]
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :edit
     end
  end
  
  def destroy
     @spost = Sponsoredpost.find(params[:id])
 
     if @spost.destroy
       flash[:notice] = "\"#{@spost.title}\" was deleted successfully."
       redirect_to @spost.topic
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
  end
end
