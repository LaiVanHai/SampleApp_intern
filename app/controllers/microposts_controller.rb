class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = t "micropost.succ"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate page: params[:page]
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t "micropost.delete"
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]

    return if micropost
    flash[:danger] = t "micropost.err2"
    redirect_to root_url
  end
end