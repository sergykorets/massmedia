class Authors::TagsController < AuthorController

  def create
    @tag = Tag.where(tag_params).first_or_create
    respond_to do |format|
      if @tag.save
        format.json { render json: @tag }
        format.html { redirect_to blog_tags_path, notice: 'Category was successfully created' }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to blog_tags_path, notice: 'Category was successfully updated' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to blog_tags_url, notice: 'Category was successfully destroyed' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name, :description)
    end
end
