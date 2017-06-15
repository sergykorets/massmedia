class Authors::TagsController < AuthorController

  def create
    @tag = Tag.where(tag_params).first_or_create
    if @tag.save
      render json: @tag
    else
      render json: { errors: @tag.errors.full_messages }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name, :description)
    end
end
