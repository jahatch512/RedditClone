class SubsController < ApplicationController

  before_action :is_moderator?, only: [:edit]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def is_moderator?
    subb = Sub.find_by(id: params[:id])
    unless current_user.subs.include?(subb)
      flash[:errors] = ["you are not the moderator of this sub"]
      redirect_to sub_url
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description, :user_id)
  end
end
