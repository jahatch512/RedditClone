class PostsController < ApplicationController

  before_action :is_author?, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub][:id]
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.author_id = current_user.id
    @post.sub_is = params[:sub][:id]
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def destroy
    Post.find_by(id: params[:id]).delete
  end

  def show
    @post = Post.find_by(id: params[:id])
    render :show
  end

  def is_author?
    post = Post.find_by(id: params[:id])
    unless current_user.posts.include?(post)
      flash[:errors] = ["you didn't write this"]
      redirect_to post_url
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
