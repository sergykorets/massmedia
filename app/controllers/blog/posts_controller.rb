module Blog
	class PostsController < BlogController

    def index
   	  if params[:category].present?
        @posts = published_posts.most_recent.tagged_with(params[:category]).paginate(:page => params[:page], :per_page => 6)
   	  else
        @posts = published_posts.most_recent.paginate(:page => params[:page], :per_page => 6)
      end
    end

    def show
      @post = published_posts.friendly.find(params[:id])
      @comments = @post.comments.order("created_at DESC")
      @comment = @post.comments.build
    end

    private

    def published_posts
      Post.published
    end
  end
end