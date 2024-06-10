class ScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  def show
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @score = Score.find(params[:id])
  end

  def new
    @score = @comment.scores.new
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:comment_id])
    score = comment.scores.build(score_params)
    score.user_id = current_user.id
    if score.save
      flash[:success] = "scoreを作成しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "scoreを作成できませんでした"
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:comment_id])
  end

  def set_score
    @score = @comment.scores.find(params[:id])
  end

  def score_params
    params.require(:score).permit(:content,:location,:daseki)
  end
end
