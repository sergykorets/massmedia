class Blog::TagsController < BlogController

  def index
    @categories = Tag.order("taggings_count DESC").search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end
end