module Blog
  class CommentsController < BlogController
    before_action :authenticate_author!, except: :index
    before_action :define_post
    before_action :set_comment, only: :destroy

    # GET /reviews
    # GET /reviews.json
    def index
      @comments = @post.comments
    end

    # GET /reviews/new
    def new
      @comment = Comment.new
    end

    # POST /reviews
    # POST /reviews.json
    def create
      @comment = Comment.new(comment_params)
      @comment.author_id = current_author.id
      @comment.post_id = @post.id
      respond_to do |format|
        if @comment.save
          format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { redirect_to post_path(@post), notice: 'Fill in your comment' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /reviews/1
    # DELETE /reviews/1.json
    def destroy
      @comment.destroy if current_author.id == @comment.author_id
      respond_to do |format|
        format.html { redirect_to post_url(@post), notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end

      def define_post
        @post = Post.friendly.find(params[:post_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def comment_params
        params.require(:comment).permit(:content)
      end
  end
end
