class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    @topics = Topic.paginate(page: params[:page], per_page: 10)
  end

  def new
    @topic = Topic.new
     @post = Post.new
    authorize @post
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @Topic.posts.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @topic = Topic.find(params[:id])
      @post = Post.find(params[:id])
    authorize @post
  end
   
   def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    @post.topic = @topic
    authorize @post

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
   end
  
   def destroy
     @topic = Topic.find(params[:id])
     name = @topic.name
 
     authorize @topic
     if @topic.destroy
       flash[:notice] = "\"#{name}\" was deleted successfully."
       redirect_to topics_path
     else
       flash[:error] = "There was an error deleting the topic."
       render :show
     end
   end
 
  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post

    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
   end
end
