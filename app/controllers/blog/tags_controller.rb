class Blog::TagsController < BlogController

  def index
    @categories = Tag.all
  end
end