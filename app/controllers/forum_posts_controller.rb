class ForumPostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_forum_thread, only: %i[index new create]
  before_action :set_forum_post, only: %i[show edit update destroy]

  def index
    @forum_posts = @forum_thread.forum_posts
  end

  def show
  end

  def new
    # @forum_post = @forum_thread.forum_posts.build
    @forum_post = ForumPost.new
    @forum_post.forum_thread = @forum_thread
  end

  def edit
  end

  def create
    # @forum_post = @forum_thread.forum_posts.build(forum_post_params)
    @forum_post = ForumPost.new(forum_post_params)
    @forum_post.forum_thread = @forum_thread
    if @forum_post.save
      redirect_to forum_thread_path(@forum_thread), notice: I18n.t('forum_posts.created')
    else
      redirect_to forum_thread_path(@forum_thread), alert: I18n.t('forum_posts.created')
    end
  end

  def update
    if @forum_post.update(forum_post_params)
      redirect_to forum_thread_path(@forum_thread), notice: I18n.t('forum_posts.created')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @forum_post.destroy
    redirect_to forum_thread_path(@forum_thread), notice: I18n.t('forum_posts.deleted')
  end

  private

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:forum_thread_id])
  end

  def set_forum_post
    @forum_post = ForumPost.find(params[:id])
    @forum_thread = @forum_post.forum_thread
  end

  def forum_post_params
    params.require(:forum_post).permit(:body)
  end
end
