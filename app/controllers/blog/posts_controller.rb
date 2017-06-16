class Blog::PostsController < BlogController

  def index
 	  if params[:category].present?
      @posts = published_posts.most_recent.tagged_with(params[:category]).paginate(:page => params[:page], :per_page => 6)
      @category = params[:category]
      @commentable = Tag.find_by_name(@category)
      @comment = @commentable.comments.build
 	  else
      @posts = published_posts.most_recent.paginate(:page => params[:page], :per_page => 6)
    end
  end

  def show
    @commentable = published_posts.friendly.find(params[:id])
    @comment = @commentable.comments.build
  end

  private

  def published_posts
    Post.published
  end
end