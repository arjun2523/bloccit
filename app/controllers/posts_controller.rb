class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
     @post = Post.find(params[:id])
     @topic = Topic.find(params[:topic_id])
  end

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
    authorize @post
  end
  def create
     @post = current_user.posts.build(post_params)
     if @post.save
       flash[:notice] = "Post was saved."
       redirect_to @post
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :new
     end
  end
  
   def destroy
     @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:id])
     title = @post.title
     authorize @post
 
     if @post.destroy
       flash[:notice] = "\"#{title}\" was deleted successfully."
       redirect_to @topic
     else
       flash[:error] = "There was an error deleting the post."
       render :show
     end
   end
  def edit
    @post = Post.find(params[:id])
    authorize @post
  end
  def update
     @post = current_user.posts.build(post_params)
    authorize @post
     if @post.update_attributes(params.require(:post).permit(:title, :body))
       flash[:notice] = "Post was updated."
       redirect_to @post
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :edit
    end
  end
end
private

def post_params
  params.require(:post).permit(:title, :body)
end
