class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  PER = 8

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC") #N+1問題を解消
    @pages = Tweet.page(params[:page]).per(PER)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  private
  def tweet_params
    params.require(:tweet).permit(:title, :text, images: []).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
