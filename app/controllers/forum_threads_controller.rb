class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_forum_thread, only: %i[show edit update destroy]

  def index
    @forum_threads = ForumThread.all
  end

  def show
  end

  def new
    @forum_thread = ForumThread.new
  end

  def edit
  end

  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    if @forum_thread.save
      redirect_to @forum_thread, notice: I18n.t('forum_threads.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @forum_thread.update(forum_thread_params)
      redirect_to forum_thread_path(@forum_thread), notice: I18n.t('forum_threads.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @forum_thread.destroy
    redirect_to forum_threads_path, notice: I18n.t('forum_threads.deleted')
  end

  private

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:id])
  end

  def forum_thread_params
    params.require(:forum_thread).permit(:subject)
  end
end
