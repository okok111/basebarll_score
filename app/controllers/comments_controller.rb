class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:id])
      @scores = @comment.scores
      @score = Score.new
    end

    def create
      post = Post.find(params[:post_id])
      comment = post.comments.build(comment_params) 
      comment.user_id = current_user.id
      if comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
      end
    end
  
    private
  
      def comment_params
        params.require(:comment).permit(:content,:result)
      end
end
