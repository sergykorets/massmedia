class Blog::TagsController < BlogController

  def index
    @categories = Tag.order("name").search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end
end