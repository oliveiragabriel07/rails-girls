class LikesController < ApplicationController
  before_action :set_like, only: :destroy

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)
    @like.user = current_user

    respond_to do |format|
      if @like.save
        format.js
      else
        format.js
      end
    end
  end

  # DELETE /likes
  # DELETE /likes.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
